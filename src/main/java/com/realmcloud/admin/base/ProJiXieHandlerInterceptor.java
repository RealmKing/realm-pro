package com.realmcloud.admin.base;

import com.realmcloud.admin.entity.Site;
import com.realmcloud.admin.service.SiteService;
import org.slf4j.Logger;
import org.springframework.beans.factory.BeanFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.context.support.WebApplicationContextUtils;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Created by realm  on 2017/11/30.
 * todo:机械网站
 */
@Component
public class ProJiXieHandlerInterceptor implements HandlerInterceptor {
    private static final Logger LOGGER = org.slf4j.LoggerFactory.getLogger(ProJiXieHandlerInterceptor.class);

    @Autowired
    private SiteService siteService;

    @Override
    public boolean preHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o) {
        if (siteService == null) {//解决service为null无法注入问题
            BeanFactory factory = WebApplicationContextUtils.getRequiredWebApplicationContext(httpServletRequest.getServletContext());
            siteService = (SiteService) factory.getBean("siteService");

        }
        Site site = siteService.getCurrentSite();
        if(site != null){
            httpServletRequest.setAttribute("site",site);
            return true;
        }
        return false;
    }

    @Override
    public void postHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, ModelAndView modelAndView) {

    }

    @Override
    public void afterCompletion(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e) {

    }
}
