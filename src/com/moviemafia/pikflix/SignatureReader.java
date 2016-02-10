package com.moviemafia.pikflix;

import java.io.*;
public class SignatureReader {

    public static String getSignature(String dirPath){
        String[] cmd = {
                "/bin/sh",
                "-c",
                "/usr/bin/find "+dirPath+" -not -path \"*/signature/*\" -exec /usr/bin/md5sum {} + | /usr/bin/awk '{print $1}' | /usr/bin/sort | /usr/bin/md5sum"
        };
       String output = "";
       try {
            Process p = Runtime.getRuntime().exec(cmd);
            BufferedReader in = new BufferedReader(
                                new InputStreamReader(p.getInputStream()));
            String line = null;
            while ((line = in.readLine()) != null) {
                output += line;
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
	return output;
    }

    public static void main(String[] args) {
        System.out.println(getSignature(args[0]));
    }
}
