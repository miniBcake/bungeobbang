package memberController;

import jakarta.servlet.http.HttpSession;
import model.dto.MemberDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class DeleteMemberController {
	// 회원탈퇴
	
	@Autowired
	private MemberService memberService;
	
	@PostMapping(value="/deleteMember.do")
	public String deleteMember(HttpSession session, MemberDTO memberDTO) {
		// View에서 받아올 데이터 없음

		// session에서 회원번호(PK)값 받아옴
		int memberNum = (int)session.getAttribute("userPK");

		// MemberDTO, DAO 객체 new 생성
		memberDTO.setMemberNum(memberNum);

		// MemberDAO.delete 요청
		// 결과값(boolean flag) 받아오기
		boolean flag = memberService.delete(memberDTO);

		// 계정 삭제 성공
		// flag가 true라면
		if(flag) {
			// 모든 session 삭제
			// invalidate 사용
			session.invalidate();

			// 이동 페이지 : mainPage.do
			return "redirect:mainPage.do";
		}
		
	}

}
