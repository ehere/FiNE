/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller.upload;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import org.json.simple.JSONObject;

/**
 *
 * @author tanasab
 */
@WebServlet(name = "UploadServlet", urlPatterns = {"/UploadServlet"})
@MultipartConfig
public class UploadServlet extends HttpServlet {

    private List<String> allow_type = Arrays.asList("gif", "png", "jpg", "bmp", "svg", "tif", "webp", "mp3", "wav", "ogg");
    private final static Logger LOGGER
            = Logger.getLogger(UploadServlet.class.getCanonicalName());

    protected void processRequest(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("utf-8");

        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd_HH-mm-ss");
        //get current date time with Date()
        Date date = new Date();
        String datetime = dateFormat.format(date);
        // Create path components to save the file
        String path = "";
        long max_size = 0;
        if (request.getParameter("action").equals("cover")) {
            path = "/img/cover";
            max_size = 300*1024;
        } else if (request.getParameter("action").equals("bg")) {
            path = "/img/bg";
            max_size = 1*1024*1024;
        } else if (request.getParameter("action").equals("music")) {
            path = "/sound/bgm";
            max_size = 5*1024*1024;
        } else if (request.getParameter("action").equals("voice")) {
            path = "/sound/voice";
            max_size = 1*1024*1024;
        }
        final Part filePart = request.getPart("file");
        String fileName = getFileName(filePart).toLowerCase();
        String relativeWebPath = path;
        String absoluteDiskPath = getServletContext().getRealPath(relativeWebPath);

        JSONObject respond = new JSONObject();
        respond.put("status", 0);
        // creates the save directory if it does not exists
        File fileSaveDir = new File(absoluteDiskPath);
        if (!fileSaveDir.exists()) {
            fileSaveDir.mkdir();
        }

        OutputStream out = null;
        InputStream filecontent = null;
        final PrintWriter writer = response.getWriter();

        try {

            if (filePart.getSize() == 0) {
                respond.put("message", "Please select file before upload.");
                writer.println(respond.toJSONString());
            } else if (!allow_type.contains(getFileType(fileName))) {
                respond.put("message", "File type not allow.");
                writer.println(respond.toJSONString());
            } else if (filePart.getSize() > max_size) {
                respond.put("message", "File too Big.");
                writer.println(respond.toJSONString());
            } else {
                out = new FileOutputStream(new File(absoluteDiskPath + File.separator
                        + datetime + "_" + fileName));
                filecontent = filePart.getInputStream();

                int read = 0;
                final byte[] bytes = new byte[1024];

                while ((read = filecontent.read(bytes)) != -1) {
                    out.write(bytes, 0, read);
                }

                respond.put("status", 1);
                respond.put("filename", datetime + "_" + fileName);
                writer.println(respond.toJSONString());
                LOGGER.log(Level.INFO, "File{0}being uploaded to {1}",
                        new Object[]{datetime + "_" + fileName, absoluteDiskPath});

            }
        } catch (FileNotFoundException fne) {
            writer.println("You either did not specify a file to upload or are "
                    + "trying to upload a file to a protected or nonexistent "
                    + "location.");
            writer.println("<br/> ERROR: " + fne.getMessage());

            LOGGER.log(Level.SEVERE, "Problems during file upload. Error: {0}",
                    new Object[]{fne.getMessage()});
        } finally {
            if (out != null) {
                out.close();
            }
            if (filecontent != null) {
                filecontent.close();
            }
            if (writer != null) {
                writer.close();
            }
        }

    }

    private String getFileType(String filename) {
        String[] name = filename.split("\\.");
        return name[name.length - 1];
    }

    private String getFileName(final Part part) {
        final String partHeader = part.getHeader("content-disposition");
        LOGGER.log(Level.INFO, "Part Header = {0}", partHeader);
        for (String content : part.getHeader("content-disposition").split(";")) {
            if (content.trim().startsWith("filename")) {
                return content.substring(
                        content.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return null;
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
