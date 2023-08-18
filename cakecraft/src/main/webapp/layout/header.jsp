<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script>
//로그아웃 버튼 클릭시
function logout() {
    if (localStorage.getItem('rememberedId') !== null) {
        localStorage.removeItem('rememberedId');

        // 로컬스토리지 + 세션 정보 삭제
        fetch('/cakecraft/logout', {
            method: 'GET',
            credentials: 'same-origin'
        }).then(response => {
            if (response.ok) {
                alert('로그아웃 완료');
                location.reload(); // 페이지 새로고침
            } else {
                alert('로그아웃 실패');
            }
        });
    } else {
        alert('로그인하세요!');
    }
}
</script>
<nav class="navbar navbar-expand-md custom-navbar">
  <!-- Brand -->
  <a class="navbar-brand" href="/cakecraft/schedule/schedule">cake craft</a>

  <!-- Toggler/collapsibe Button -->
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#collapsibleNavbar">
    <span class="navbar-toggler-icon"></span>
  </button>

  <!-- Navbar links -->
  <div class="collapse navbar-collapse" id="collapsibleNavbar">
    <ul class="navbar-nav">
      <li class="nav-item">
		<button type="button" onclick="logout()">로그아웃</button>
      </li>
    </ul>
  </div>
</nav>
