package com.xtream.api.Controller;

import com.xtream.api.Model.ChangeStatus;
import com.xtream.api.Services.RefundService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;


@RestController
@CrossOrigin
public class RefundController {
    @Autowired
    private RefundService refundService;

    @PostMapping("/api/refund")
    public ResponseEntity refund(@RequestBody ChangeStatus status) {
        if (!status.isValidTransaction()) return ResponseEntity.badRequest().body("{\"error\": \"Esa transaccion no puede ser nula...\"}");

        try{
            refundService.refund(status);
        }catch (Exception ex){
            return ResponseEntity.badRequest().body("{\"error\": \"Esa transaccion no existe...\"}");
        }

        return ResponseEntity.ok().build();
    }

    @PostMapping("/api/change_status")
    public ResponseEntity changeStatus(@RequestBody ChangeStatus status){
        if (!status.isValidTransaction()) return ResponseEntity.badRequest().body("{\"error\": \"Esa transaccion no puede ser nula...\"}");

        try{
            refundService.changeStatus(status);
        }catch (Exception ex){
            return ResponseEntity.badRequest().body("{\"error\": \"Esa transaccion no existe...\"}");
        }

        return ResponseEntity.ok().build();
    }
}
