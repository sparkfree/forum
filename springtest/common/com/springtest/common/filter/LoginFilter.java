package com.springtest.common.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * 登录过滤器
 * 
 * @author 李帅康
 * @since 2016.6.16
 * 
 */
public class LoginFilter implements Filter {
	private String notFilterDir = "";// 不在过滤范围之内
	protected Log log = LogFactory.getLog(this.getClass());
	private FilterConfig filterConfig;

	@Override
	public void destroy() {
		notFilterDir = null;
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		try {
			HttpServletRequest req = (HttpServletRequest) request;
			HttpServletResponse res = (HttpServletResponse) response;
			String uri = req.getRequestURI();// 请求路径

			String[] notFilterDirs = notFilterDir.split(",");
			for (int i = 0; i < notFilterDirs.length; i++) {
				String notFilterDirValue = notFilterDirs[i];
				if (uri.indexOf(notFilterDirValue) != -1) {
					chain.doFilter(request, response);
					return;
				}
			}
			HttpSession session = req.getSession();//获取session对象
			if (session.getAttribute("user") == null) {
				//res.sendRedirect(this.filterConfig.getServletContext().getContextPath() + "/index.jsp");//login.do
			} else {
				chain.doFilter(request, response);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void init(FilterConfig config) throws ServletException {
		// TODO Auto-generated method stub
		this.filterConfig = config;
		notFilterDir = filterConfig.getInitParameter("notFilterDir");
	}

}
