package com.realmcloud.admin.base;

import com.realmcloud.admin.entity.User;
import com.realmcloud.admin.realm.AuthRealm.ShiroUser;
import com.realmcloud.admin.service.*;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;

public class BaseController {
	
	public User getCurrentUser() {
		ShiroUser shiroUser = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
		if(shiroUser == null) {
			return null;
		}
		User loginUser = userService.selectById(shiroUser.getId());
		return loginUser;
	}

	@Autowired
	protected UserService userService;

	@Autowired
	protected MenuService menuService;

	@Autowired
	protected RoleService roleService;

	@Autowired
	protected DictService dictService;

	@Autowired
	protected RescourceService rescourceService;

	@Autowired
	protected TableService tableService;

	@Autowired
	protected SiteService siteService;

	@Autowired
	protected LogService logService;

	@Autowired
	protected BlogArticleService blogArticleService;

	@Autowired
	protected BlogChannelService blogChannelService;

	@Autowired
	protected BlogCommentService blogCommentService;

	@Autowired
	protected BlogTagsService blogTagsService;

	@Autowired
	protected UploadInfoService uploadInfoService;
}
