package Filter;/*
 *		Created by IntelliJ IDEA.
 *		UserMess:龙猫
 *		Date: 2018/11/24
 *		Time: 14:23
 *      email: foxmaillucien@126.com
 *      Description:所有请求都走此过滤器来判断用户是否登录
 */


import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Arrays;

public class UserFilter implements Filter {
	private FilterConfig filterConfig;
	private String userSessionKey;		//用户信息存放到session中的键的名字
	private String redirectPage;		//重定向地址
	private String unCheckedUrls;		//不需要检测的URL
	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		this.filterConfig = filterConfig;
		ServletContext servletContext = filterConfig.getServletContext();
		//获取XML配置参数
		userSessionKey = servletContext.getInitParameter("userSessionKey");
		redirectPage = servletContext.getInitParameter("redirectPage");
		unCheckedUrls = servletContext.getInitParameter("unCheckedUrls");
	}

	@Override
	public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
		//类型转换
		HttpServletRequest httpServletRequest = (HttpServletRequest) servletRequest;
		HttpServletResponse httpServletResponse = (HttpServletResponse) servletResponse;

		String servletPath = httpServletRequest.getServletPath();		//获取请求URL

		//1、判断URL是否需要检查
		List<String> urls = Arrays.asList(unCheckedUrls.split(","));
		if (urls.contains(servletPath)){
			filterChain.doFilter(httpServletRequest,httpServletResponse);
			return;
		}

		//2、判断用户是否登录
		Object user = httpServletRequest.getSession().getAttribute(userSessionKey);
		if (user == null){
			httpServletResponse.sendRedirect(httpServletRequest.getContextPath() + redirectPage);			//不存在则重定向到redirectPage
			return;
		}

		//3、若存在，则放行
		filterChain.doFilter(httpServletRequest,httpServletResponse);
	}

	@Override
	public void destroy() {

	}
}
