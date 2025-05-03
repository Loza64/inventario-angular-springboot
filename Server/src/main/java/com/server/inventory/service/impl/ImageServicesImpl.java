package com.server.inventory.service.impl;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import com.server.inventory.service.interfaces.ImageServices;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@Service
public class ImageServicesImpl implements ImageServices {

    private final Cloudinary cloudinary;

    public ImageServicesImpl(@Lazy Cloudinary cloudinary){
        this.cloudinary = cloudinary;
    }

    @Override
    public Map<String, Object> UploadImage(MultipartFile image) throws IOException {

        Map<String, Object> options = new HashMap<>();
        options.put("folder", "Inventory");
        var result = cloudinary.uploader().upload(image.getBytes(), options);

        Map<String, Object> map = new HashMap<>();
        map.put("url", result.get("url").toString());
        map.put("public_id", result.get("public_id").toString());
        return map;
    }

    @Override
    public Boolean DestroyImage(String public_id) throws IOException {
        var result = cloudinary.uploader().destroy(public_id, ObjectUtils.emptyMap());
        return result.get("result").equals("ok");
    }
}
