package servlet;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.alibaba.fastjson.JSON;

import entity.User;
import model.Model;
import utils.MyExcelUtils;

/**
 * Servlet implementation class uploadServlet
 */
@MultipartConfig
@WebServlet("/uploadServlet")
public class uploadServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public uploadServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		// ���ñ���
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/json;charset=utf-8");
		// ��ȡPart�ļ��ϴ�����
		Part part = request.getPart("excelFile");

		// ��ȡPrintWriter���󣬿�������ҳ��ʾ��ʾ��Ϣ
		PrintWriter printWriter = response.getWriter();

		if (part != null) {
			// ��ȡ�ļ�ͷ��Ϣ
			String fileHeader = part.getHeader("Content-Disposition");
			// �ļ���
			String fileName = fileHeader.substring(fileHeader.lastIndexOf("=") + 2, fileHeader.length() - 1);
			// ��ȡ������
			InputStream inputStream = part.getInputStream();
			
			if(!"".equals(fileName)) {
				if(MyExcelUtils.validFileIsExcel(fileName)) {
					List<User> users = MyExcelUtils.getExcelData(inputStream, fileName);
					// ���û���Ϣ��һ���ӵ����ݿ�
					Model model = new Model();
					String msg = "";
					for (User user : users) {
						int isSuccess = model.insert(user.getId(), user.getName(), user.getPassword());
						if (isSuccess > 0) {
							msg += "<span style='color: green; font-family: FangSong; font-size: 17px;'>"
									+ user.getId() + " " + user.getName()
									+ " " + user.getPassword() + " Add successfully!</span><br/>";
						} else {
							msg += "<span style='color: red; font-family: FangSong; font-size: 17px;'>" +
									user.getId() + " " + user.getName()
									+ " " + user.getPassword() + " already exists!!!</span><br/>";
						}
					}
					request.setAttribute("msg", msg);
					// ɾ��������ļ�,�ͷ���Դ
					part.delete();
					request.getRequestDispatcher("uploadShow.jsp").forward(request, response);
					
				}else {
					printWriter.write("<h1 style='color: red'>�ļ���ʽ��֧�֣���֧��excel�����ļ�</h1>");
				}
			}else {
				printWriter.write("<h1 style='color: red'>�ļ����𻵻򲻴���</h1>");
			}
			
		} else {
			printWriter.write("<h1 style='color: red'>δ��ȡ���ļ�</h1>");
		}
		// ɾ��������ļ�,�ͷ���Դ
		part.delete();
		printWriter.flush();
		printWriter.close();
	}

}