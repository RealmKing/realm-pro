package com.realmcloud.admin.service;

import com.baomidou.mybatisplus.service.IService;
import com.realmcloud.admin.entity.SysCodeRule;

import java.util.List;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author realm
 * @since 2017-10-31
 */
public interface SysCodeRuleService extends IService<SysCodeRule> {

    SysCodeRule save(SysCodeRule sysCodeRule);

    SysCodeRule getById(Long id);

    void update(SysCodeRule sysCodeRule);

    void delete(SysCodeRule sysCodeRule);

    Integer getNameCount(String name);

    List<SysCodeRule> selectAll();
	
}
