<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:url var="homeUrl" value="/" />
<c:url var="cssUrl" value="/css/" />
<c:url var="imgUrl" value="/img/" />
<link rel="stylesheet" href="${cssUrl}header.css">
<header>
	<section class="title">
		<div class="header-container">
			<div class="header-wrapper">
				<div class="logo-box" onclick="location.href='${homeUrl}'">
					<img src="${imgUrl}logo-kdi.png" alt="">
					<h1 class="header-title">K-PaaS Data Integration</h1>
				</div>
				<nav class="menu-wrapper menuListHover">
					<ul class="menuBox header5">
						<li class="menuBar">메뉴 로딩중...</li>
					</ul>
				</nav>
				<div style="width: 220px;">
					<sec:authorize access="isAuthenticated()">
						<a class="button-primary" href="${homeUrl}member/logout" style="padding: 12px 30px;">로그아웃</a>
					</sec:authorize>
				</div>
			</div>
			<div class="dropdown-menu menuListHover">
				<%-- 마진 맞추기위한 hidden 요소임--%>
				<div class="menu-list">
					<div class="logo-box" style="visibility: hidden">
						<img src="${imgUrl}logo-kdi.png" alt="">
						<h1 class="header-title">K-PaaS Data Integration</h1>
					</div>
					<div class="flex-col">서브메뉴 로딩중...</div>
					<%--마진 맞추기위한 hidden 요소임--%>
					<div style="visibility: hidden; width: 220px;">
						<div class="button-primary" style="padding: 12px 30px;">로그아웃</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<div style="display: none;">
		<ul class="menu-box-list-format">
			<li class="menuBar" onclick="location.href='#URI#'">#TITLE#</li>
		</ul>
		<div class="flex-col-format">
			<nav class="menu-wrapper">
				<ul class="menu-hover-box body1 gray500"></ul>
			</nav>
		</div>
		<ul class="menu-hover-box-html">
			<li class="menu-hover-content" onclick="#URI#">#TITLE#</li>
		</ul>
		<ul class="menu-hover-box-blank-html">
			<li class="menu-hover-content blank-content"></li>
		</ul>
	</div>
	<script defer>
		var hoveringMenu = false;
		var menuDatas = [ {
			title : '모니터링',
			uri : 'monitoring',
			submenu : [ // submenu START 향후 목표 대시보드, 서비스 상태, 연계 현황, 서비스 로그
			{
				title : '연계 모니터링',
				uri : 'monitoring'
			}, {
				title : '로그 조회',
				uri : 'monitoring'
			}
			// submenu END
			]
		}, {
			title : '자원관리',
			uri : 'res/ds',
			submenu : [ // submenu START
			{
				title : '데이터소스',
				uri : 'res/ds'
			}, {
				title : '인터페이스명',
				uri : 'res/if'
			}, {
				title : '서비스 정보',
				uri : 'res/svc_info'
			}, {
				title : '송신 인터페이스',
				uri : 'res/if/send'
			}, {
				title : '수신 인터페이스',
				uri : 'res/if/recv'
			}
			/** 향후 목표
			,{
				title : '전처리 업무 관리',
				uri : 'res/work/pre'
			},
			{
				title : '후처리 업무 관리',
				uri : 'res/work/post'
			}
			 */
			// submenu END
			]
		}, {
			title : '서비스',
			uri : 'svc/status',
			submenu : [ {
				title : '서비스 상태',
				uri : 'svc/status'
			}, {
				title : '서비스 제어',
				uri : 'svc/ctl'
			} ]
		}, {
			title : '사용자정보',
			uri : 'member/userInfo',
			submenu : [ {
				title : '사용자정보 조회',
				uri : 'member/userInfo'
			}, {
				title : '사용자정보 수정',
				uri : 'member/userInfoEdit'
			} ]
		}, {
			title : 'What\'s KDI',
			uri : '',
			submenu : []
		}
		//
		];

		const menuWrite = function() {
			// title
			const menuBox = $('.menuBox');
			menuBox.html(''); // 초기화
			const menuBoxListHtml = $('.menu-box-list-format').html();

			// submenu
			const flexCol = $('.flex-col');
			flexCol.html(''); // 초기화
			const flexColFormat = $('.flex-col-format').html();
			const menuHoverBoxHtml = $('.menu-hover-box-html').html();
			const menuHoverBoxBlankHtml = $('.menu-hover-box-blank-html')
					.html();
			let subMenuMaxSize = 0;

			// titlemenu write
			$.each(menuDatas, function(idx, menuData) {
				const menuBoxTitle = menuData.title;
				const menuBoxUri = contextPath + menuData.uri;
				menuBox.append(menuBoxListHtml.replaceAll('#TITLE#', menuBoxTitle).replaceAll('#URI#', menuBoxUri));
				if (subMenuMaxSize < menuData.submenu.length) {
					subMenuMaxSize = menuData.submenu.length;
				}
			});
			// submenu write
			for(var i = 0; i < subMenuMaxSize; i++){
				// submenu init
				flexCol.append(flexColFormat);
			}
			$.each(menuDatas, function(idx, menuData) {
				$.each(menuData.submenu, function(subIdx, subMenuData) {
					const menuHoverBox = flexCol.find(':nth-child(' + (subIdx + 1) + ') .menu-hover-box');
					const flexColTitle = subMenuData.title;
					const flexColUri = contextPath + subMenuData.uri;
					menuHoverBox.append(menuHoverBoxHtml.replaceAll('#TITLE#', flexColTitle).replaceAll('#URI#', flexColUri));
				});
				// 칸 맞추기위한 공백 추가
				for (var i = menuData.submenu.length + 1; i <= subMenuMaxSize; i++) {
					const menuHoverBox = flexCol.find(':nth-child(' + i + ') .menu-hover-box');
					menuHoverBox.append(menuHoverBoxBlankHtml);
				}
			});
		}

		$(document).ready(function() {
			menuWrite();

			$(".menuListHover").hover(function() {
				$(".dropdown-menu").stop().slideToggle(300);
			}, function() {
				$(".dropdown-menu").stop().slideToggle(500);
			});
		})
	</script>
</header>


