package com.team29.utils;

import com.aliyun.oss.OSS;
import com.aliyun.oss.OSSClientBuilder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;
import java.io.*;
import java.util.UUID;

public class AliOSSUtils {

    private static String endpoint = "https://oss-cn-hangzhou.aliyuncs.com" ;
    private static String accessKeyId = "LTAI5tLJ9PAaq4LvGN11YwuY";
    private static String accessKeySecret = "KBKhfSuCDfTUV967E44uGKZMuCdz2M" ;
    private static String bucketName = "web-bmsystem";

    public static String uploadBookImage(MultipartFile file, String bId) {
        try {
            // 获取上传的文件的输入流
            InputStream inputStream = file.getInputStream();
            String fileName = "books/" + bId + ".png";

            //上传文件到 OSS
            OSS ossClient = new OSSClientBuilder().build(endpoint, accessKeyId, accessKeySecret);
            ossClient.putObject(bucketName, fileName, inputStream);

            //文件访问路径
            String url = endpoint.split("//")[0] + "//" + bucketName + "." + endpoint.split("//")[1] + "/" + fileName;

            // 关闭ossClient
            ossClient.shutdown();

            return url;// 把上传到oss的路径返回
        } catch (Exception e) {
            return "fail";
        }
    }

}
