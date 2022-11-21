package kr.co.seoulit.insa.empmgmtsvc.empinfomgmt.controller;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import kr.co.seoulit.insa.empmgmtsvc.empinfomgmt.service.EmpInfoService;
import kr.co.seoulit.insa.empmgmtsvc.empinfomgmt.to.EmpAppointmentInfoTO;
import kr.co.seoulit.insa.empmgmtsvc.empinfomgmt.to.EmpAppointmentRegTO;
import kr.co.seoulit.insa.empmgmtsvc.empinfomgmt.to.EmpAppointmentTO;
import kr.co.seoulit.insa.empmgmtsvc.empinfomgmt.to.EmpAppointmentTypeTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;

@RequestMapping("/empinfomgmt/*")
@RestController
public class EmpAppointmentController {

    @Autowired
    private EmpInfoService empInfoService;

    ModelMap map = null;

    @GetMapping("appointment")
    public ModelMap findAllAppointInfo() {

        map = new ModelMap();
        try {
            ArrayList<EmpAppointmentInfoTO> list = empInfoService.allEmpAppointInfo();
            map.put("infoList", list);
        } catch (Exception e) {
            map.put("errorCode", -1);
            map.put("errorMsg", e.getMessage());
        }
        return map;
    }

    @GetMapping("appointmentemp")
    public ModelMap findAllAppointEmp(@RequestParam String hosu) {

        map = new ModelMap();
        try {
            ArrayList<EmpAppointmentTypeTO> list = empInfoService.findAllAppointEmp(hosu);
            EmpAppointmentTO list1 = empInfoService.countAppointmentEmp(hosu);
            map.put("list", list);
            map.put("countlist", list1);
        } catch (Exception e) {
            map.put("errorCode", -1);
            map.put("errorMsg", e.getMessage());
        }
        return map;
    }

    @GetMapping("appointmentemptype")
    public ModelMap findAppointmentEmp(@RequestParam String hosu, String type) {

        map = new ModelMap();
        try {
            ArrayList<EmpAppointmentTypeTO> list = empInfoService.findAppointmentInfoEmp(hosu, type);
            map.put("typelist", list);
        } catch (Exception e) {
            map.put("errorCode", -1);
            map.put("errorMsg", e.getMessage());
        }
        return map;
    }

    @GetMapping("gethosu")
    public ModelMap registhosu() {

        map = new ModelMap();
        try {
            EmpAppointmentInfoTO infoTO = empInfoService.generateHosu();
            map.put("infoTO", infoTO);
        } catch (Exception e) {
            map.put("errorCode", -1);
            map.put("errorMsg", e.getMessage());
        }
        return map;
    }

    @PostMapping("registAppoint")
    public ModelMap registAppointment(@RequestParam String after1,String after2,String after3,String empCode,String hosu) {
        map = new ModelMap();
        try {
            System.out.println(after1);
            System.out.println(after2);
            System.out.println(after3);
            Gson gson = new Gson();
            ArrayList<EmpAppointmentRegTO> empAppointmentTo1 = gson.fromJson(after1, new TypeToken<ArrayList<EmpAppointmentRegTO>>() {
            }.getType());
            ArrayList<EmpAppointmentRegTO> empAppointmentTo2 = gson.fromJson(after2, new TypeToken<ArrayList<EmpAppointmentRegTO>>() {
            }.getType());
            ArrayList<EmpAppointmentRegTO> empAppointmentTo3 = gson.fromJson(after3, new TypeToken<ArrayList<EmpAppointmentRegTO>>() {
            }.getType());
            for (EmpAppointmentRegTO to : empAppointmentTo1) {
                to.setEmpCode(empCode);
                to.setHosu(hosu);
            }
            for (EmpAppointmentRegTO to : empAppointmentTo2) {
                to.setEmpCode(empCode);
                to.setHosu(hosu);
            }
            for (EmpAppointmentRegTO to : empAppointmentTo3) {
                to.setEmpCode(empCode);
                to.setHosu(hosu);
            }
            ArrayList<ArrayList<EmpAppointmentRegTO>> arr = new ArrayList<ArrayList<EmpAppointmentRegTO>>();
            arr.add(empAppointmentTo1);
            arr.add(empAppointmentTo2);
            arr.add(empAppointmentTo3);

            empInfoService.registAppoint(arr);

        } catch (Exception e) {
            map.put("errorCode", -1);
            map.put("errorMsg", e.getMessage());
        }
        return map;
    }

    @GetMapping("findAppointment")
    public ModelMap findAppointmentList() {
        map = new ModelMap();
        try {
            ArrayList<EmpAppointmentTO> appointmentList = empInfoService.findAppointmentList();
            map.put("appointmentList", appointmentList);
            map.put("errorMsg", "success");
            map.put("errorCode", 0);

        } catch (Exception dae) {
            map.clear();
            map.put("errorCode", -1);
            map.put("errorMsg", dae.getMessage());
        }

        return map;
    }

    @GetMapping("findDetailAppointment")
    public ModelMap findDetailAppointmentList(@RequestParam String hosu) {
        map = new ModelMap();
        try {
            ArrayList<EmpAppointmentTO> detailAppointmentList = empInfoService.findDetailAppointmentList(hosu);
            map.put("detailAppointmentList", detailAppointmentList);
            map.put("errorMsg", "success");
            map.put("errorCode", 0);

        } catch (Exception dae) {
            map.clear();
            map.put("errorCode", -1);
            map.put("errorMsg", dae.getMessage());
        }

        return map;
    }

    @GetMapping("findChangeDetail")
    public ModelMap findChangeDetail(@RequestParam String empCode, String hosu) {
        map = new ModelMap();
        try {
            ArrayList<EmpAppointmentTO> changeDetailList = empInfoService.findChangeDetailList(empCode, hosu);
            map.put("changeDetailList", changeDetailList);
            map.put("errorMsg", "success");
            map.put("errorCode", 0);

        } catch (Exception dae) {
            map.clear();
            map.put("errorCode", -1);
            map.put("errorMsg", dae.getMessage());
        }

        return map;
    }

    @PutMapping("confirmAppointment")
    public ModelMap modifyAppointment(@RequestBody ArrayList<EmpAppointmentTO> empAppointmentTo) {
        map = new ModelMap();
        try {
            empInfoService.modifyAppointment(empAppointmentTo);
            System.out.println("컨트롤러 : " + empAppointmentTo);
            map.put("errorMsg", "success");
            map.put("errorCode", 0);
        } catch (Exception dae) {
            map.clear();
            map.put("errorCode", -1);
            map.put("errorMsg", dae.getMessage());
        }
        return map;
    }
}
