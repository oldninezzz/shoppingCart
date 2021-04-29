package IdentiCode;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.BufferedOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Random;
import javax.imageio.*;

@WebServlet(name = "GenerateCode", value = "/GenerateCode")
public class GenerateCode extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        System.out.println(666);
        BufferedImage image = new BufferedImage(100, 35, BufferedImage.TYPE_INT_RGB);
        String s = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        Graphics g = image.getGraphics();
        g.setColor(new Color(246, 243, 219));
        g.fillRect(0, 0, 100, 35);
        Random rnd;
        if(request.getParameter("seed")==null){
            rnd = new Random();
        }
        else{
            rnd = new Random(Long.parseLong(request.getParameter("seed")));
        }
        StringBuffer sb = new StringBuffer();
        Font[] f = {new Font("", Font.ITALIC, 25), new Font("", Font.BOLD, 25), new Font("", Font.PLAIN, 25), new Font("", Font.HANGING_BASELINE, 25)};
        int red, green, blue;
        for(int i=0;i<4;i++){
            int randNum = rnd.nextInt(62);
            int randFont = rnd.nextInt(4);
            rnd = new Random();
            sb.append(s.charAt(randNum));
            red = rnd.nextInt(255);
            green = rnd.nextInt(255);
            blue = rnd.nextInt(255);
            g.setColor(new Color(red, green, blue));
            g.setFont(f[randFont]);
            g.drawString(String.valueOf(s.charAt(randNum)), 15+i*18, 15+randFont*5);
        }

//        String randStr = String.valueOf(randNum);
        request.getSession().setAttribute("randStr", sb.toString());

        ImageIO.write(image, "JPEG", response.getOutputStream());
//        OutputStream out = response.getOutputStream();


    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
