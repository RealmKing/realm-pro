package com.realmcloud.admin.service;

import com.realmcloud.admin.entity.Site;
import com.baomidou.mybatisplus.service.IService;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author realm
 * @since 2017-12-30
 */
public interface SiteService extends IService<Site> {

    Site getCurrentSite();

    void updateSite(Site site);
	
}
