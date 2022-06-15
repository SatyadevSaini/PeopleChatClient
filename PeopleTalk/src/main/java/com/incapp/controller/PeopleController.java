package com.incapp.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.FileSystemResource;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;

import com.incapp.beans.ReCaptchaResponse;
import com.incapp.beans.Message;
import com.incapp.beans.User;

@Controller
public class PeopleController {
	private String URL="http://localhost:3333/";
	
	RestTemplate restTemplate=new RestTemplate();
	
	@RequestMapping("/")
	public String home() {
		return "index";
	}
	
	@PostMapping("/addUser")
	public String addUser(@ModelAttribute User u,@RequestPart("photo") MultipartFile photo, Model m) {
		String API="addUser/normal";
		
		
		
		HttpHeaders header = new HttpHeaders();
		header.setContentType(MediaType.MULTIPART_FORM_DATA);
		
		LinkedMultiValueMap<String, Object> data=new LinkedMultiValueMap<>();
		data.add("photo", convert(photo));
		data.add("user", u);
		HttpEntity<LinkedMultiValueMap<String, Object>> requestEntity=new HttpEntity(data,header);
		
		ResponseEntity<String> result=restTemplate.postForEntity(URL+API,requestEntity, String.class);
		if(result.getBody().equalsIgnoreCase("success")) {
			m.addAttribute("addResult", u.getName()+" Added Successfully!");
		}else {
			m.addAttribute("addResult", "Email Id ["+u.getEmail()+"] Already Exist!");
		}
		return "index";
	}
	
	@PostMapping("/addUserGoogle")
	public String addUserGoogle(@ModelAttribute User u,@RequestPart("photo") MultipartFile photo, Model m,HttpSession session) {
		String API="addUser/google";
		HttpHeaders header = new HttpHeaders();
		header.setContentType(MediaType.MULTIPART_FORM_DATA);
		
		LinkedMultiValueMap<String, Object> data=new LinkedMultiValueMap<>();
		data.add("photo", convert(photo));
		data.add("user", u);
		HttpEntity<LinkedMultiValueMap<String, Object>> requestEntity=new HttpEntity(data,header);
		
		ResponseEntity<String> result=restTemplate.postForEntity(URL+API,requestEntity, String.class);
		if(result.getBody().equalsIgnoreCase("success")) {
			session.setAttribute("user", u);
			return "profile";
		}else {
			m.addAttribute("addResult", "Email Id ["+u.getEmail()+"] Already Exist!");
			return "index";
		}
	}
	
	//convert MultipartFile to FileSystemResource
	public static FileSystemResource convert(MultipartFile file) {
		File convFile=new File(file.getOriginalFilename());
		try {
			convFile.createNewFile();
			FileOutputStream fos=new FileOutputStream(convFile);
			fos.write(file.getBytes());
			fos.close();
		}catch (IOException e) {
			e.printStackTrace();
		}
		return new FileSystemResource(convFile);
	}
	//end
	
	
	@Value("${google.recaptcha.verification.url}")
	String url;
	@Value("${google.recaptcha.secret}")
	String secret_key;
	
	
	@PostMapping("/login")
	public String login(@RequestParam("g-recaptcha-response") String captchaResponse,@RequestParam String email,@RequestParam String password, Model m,HttpSession session) {
		
		
		//String url="https://www.google.com/recaptcha/api/siteverify";
		//String secret_key="6LeOXC4gAAAAAD6RDiw1FyO_kgx36DSnPtIo8OMw";
		
		ResponseEntity<ReCaptchaResponse> result=restTemplate.exchange(url+"?secret="+secret_key+"&response="+captchaResponse,HttpMethod.POST,null,ReCaptchaResponse.class);
		ReCaptchaResponse rr=result.getBody();
		if(rr.isSuccess()) {
			
			
			
			String API="login/"+email+"/"+password;
			String r=(String)restTemplate.postForObject(URL+API,null, String.class);
			if(r.equalsIgnoreCase("success")) {
				API="getUserByAccountType/normal/"+email;
				User u=restTemplate.getForObject(URL+API, User.class);
				session.setAttribute("user", u);
				return "profile";
			}else {
				m.addAttribute("loginResult", "Login Failed!");
			}
			return "index";
		}else {
			m.addAttribute("loginResult", "Please verify Captcha");
			return "index";
		}
		
		
	}
	
	@RequestMapping("/loginGoogle")
	public String loginGoogle(String email,HttpSession session,HttpServletResponse response) throws IOException {
		
		String API="getUserByAccountType/google/"+email;
		User u=restTemplate.getForObject(URL+API, User.class);
		if(u==null) {
			return "registrationForGoogleUser";
			//response.sendRedirect("registrationForGoogleUser");
		}else {
			session.setAttribute("user", u);
			return "profile";
			//response.sendRedirect("profile");
		}
		
	}
	
	@RequestMapping("/mylogout")
	public void logout(HttpSession session,HttpServletResponse response) throws IOException {
		session.invalidate();
		response.sendRedirect("/");
	}
	
	@RequestMapping("/profile")
	public String profile(Model m,HttpSession session){
		User user=(User)session.getAttribute("user");
		if(user!=null) {
			return "profile";
		}else {
			m.addAttribute("loginResult", "Please Login!");
			return "index";
		}
	}
	
	@RequestMapping("/peoplesearch")
	public String peoplesearch(String state,String city,String area,Model m,HttpSession session){
		User user=(User)session.getAttribute("user");
		if(user!=null) {
			
			m.addAttribute("state", state);
			m.addAttribute("city", city);
			m.addAttribute("area", area);
			
			if(area.equals("")) {
				area="nodata";
			}
			
			String API="getUserSearch/"+state+"/"+city+"/"+area+"/"+user.getEmail();
			List<User> users=restTemplate.getForObject(URL+API,List.class);
//			User[] users=restTemplate.getForObject(URL+API, User[].class);
			m.addAttribute("users", users);
			
			return "peoplesearch";
		}else {
			m.addAttribute("loginResult", "Please Login!");
			return "index";
		}
	}
	
	@RequestMapping("/talk")
	public String talk(String talk_email,Model m,HttpSession session){
		User user=(User)session.getAttribute("user");
		if(user!=null) {
			if(talk_email!=null) {
				session.setAttribute("talk_email", talk_email);
			}else {
				String e=(String)session.getAttribute("talk_email");
				talk_email=e;
			}
			String API="getUserByEmail/"+talk_email;
			User talk_user=restTemplate.getForObject(URL+API, User.class);
			session.setAttribute("talk_user", talk_user);
			
			String API1="getMessages/"+user.getEmail()+"/"+talk_user.getEmail();
			List<Message> sMessages=restTemplate.getForObject(URL+API1,List.class);
			session.setAttribute("sMessages", sMessages);
			
			String API2="getMessages/"+talk_user.getEmail()+"/"+user.getEmail();
			List<Message> rMessages=restTemplate.getForObject(URL+API2,List.class);
			session.setAttribute("rMessages", rMessages);
			return "talk";
		}else {
			m.addAttribute("loginResult", "Please Login!");
			return "index";
		}
	}
	
	@RequestMapping("/sendMessage")
	public void sendMessage(String email,String message,@RequestPart("ufile") MultipartFile file,Model m,HttpSession session,HttpServletResponse response) throws IOException{
		User user=(User)session.getAttribute("user");
		if(user!=null) {
			String sEmail=user.getEmail();
			User talk_user=(User)session.getAttribute("talk_user");
			String rEmail=talk_user.getEmail();
			String fileName=file.getOriginalFilename();
			
			Message msg=new Message();
			msg.setsEmail(sEmail);
			msg.setrEmail(rEmail);
			msg.setMessage(message);
			msg.setFileName(fileName);
			
			ResponseEntity<String> result;
			if(fileName.equals("")) {
				String API="sendMessageWithoutFile";
				HttpEntity<Message> requestEntity=new HttpEntity(msg);
				result=restTemplate.postForEntity(URL+API,requestEntity, String.class);
			}else {
				String API="sendMessage";
				HttpHeaders header = new HttpHeaders();
				header.setContentType(MediaType.MULTIPART_FORM_DATA);
				LinkedMultiValueMap<String, Object> data=new LinkedMultiValueMap<>();
				data.add("file", convert(file));
				data.add("message",msg);
				HttpEntity<LinkedMultiValueMap<String, Object>> requestEntity=new HttpEntity(data,header);
				
				result=restTemplate.postForEntity(URL+API,requestEntity, String.class);
			}
			
			if(result.getBody().equalsIgnoreCase("success")) {
				session.setAttribute("msgResult", "Message Sent Successfully!");
			}else {
				session.setAttribute("msgResult", "Message Sent Failed!");
			}
			response.sendRedirect("talk");
		}
	}
	
	@RequestMapping("/getPhoto")
	public void getPhoto(String email,HttpServletResponse response) {
		try {
			String API="getPhoto"+"/" + email;
			byte[] b=restTemplate.getForObject(URL+API,byte[].class);
			response.getOutputStream().write(b);
		}catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping("/downloadFile")
	public void downloadFile(int id,String fileName,HttpServletResponse response) {
		try {
			String API="downloadFile"+"/" + id;
			byte[] b=restTemplate.getForObject(URL+API,byte[].class);
			//for download file
			response.setContentType("APPLICATION/OCTET-STREAM");  
            response.setHeader("Content-Disposition","attachment; filename="+fileName); 
            //for pdf view 
			//response.setContentType("APPLICATION/pdf"); 
            //response.setHeader("inline","attachment; filename="+fileName); 
            
            response.getOutputStream().write(b);
		}catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	
	
	
}
