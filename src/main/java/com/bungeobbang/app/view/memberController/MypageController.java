package com.bungeobbang.app.view.memberController;

import com.bungeobbang.app.biz.member.MemberDTO;
import com.bungeobbang.app.biz.member.MemberService;
import com.bungeobbang.app.view.util.FileUtil;
import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;

@Controller
public class MypageController {

	@Autowired
	private MemberService memberService;

	@PostMapping(value = "/updateMypage.do") // 마이페이지에서 회원정보 수정 페이지로 이동할 때 데이터 전송 로직
	protected String ProfileChange(ServletContext servletContext, HttpSession session, MemberDTO memberDTO, MultipartFile file,
								   Model model) {

		// 회원 번호(PK) 가져오기
		int memberPK = (int) session.getAttribute("memberPK");

		memberDTO.setCondition("INFO_CONDITION");
		memberDTO.setMemberNum(memberPK);

		memberDTO = memberService.selectOne(memberDTO);
		if (memberDTO != null) {
			model.addAttribute("memberDTO", memberDTO);
		}
		return "updateMypage";
	}

	@PostMapping(value = "/updateProfile.do") // 회원 정보 변경 후 DB에 변경된 데이터 저장 해주는 controller
	protected String updateProfile(ServletContext servletContext, HttpSession session, MultipartFile file,
												 MemberDTO memberDTO) {

		int userPK = (int) session.getAttribute("userPK");

		memberDTO.setCondition("UPDATE_CONDITION");
		memberDTO.setMemberNum(userPK);

		// 프로필 사진 업로드 처리
		String path = "uploads/"; // 업로드할 경로
		String fileName = FileUtil.createFileName(); // 파일 이름 생성
		String profilePicPath = FileUtil.insertFile(servletContext, path, file, fileName);

		memberDTO.setMemberProfileWay(profilePicPath);

		boolean flag = memberService.update(memberDTO);
		if (!flag) {
			return "redirect:error.jsp";
		}
		return "redirect:mainPage.do";

	}
}
