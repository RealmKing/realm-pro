package com.realmcloud.admin.dao;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.realmcloud.admin.entity.Menu;
import com.realmcloud.admin.entity.Role;
import com.realmcloud.admin.entity.SysCodeRule;
import org.apache.ibatis.annotations.Param;

import java.util.Set;

/**
 * <p>
  *  Mapper 接口
 * </p>
 *
 * @author realm
 * @since 2017-10-31
 */
public interface SysCodeRuleDao extends BaseMapper<SysCodeRule> {

    Role selectRoleById(@Param("id") Long id);

    void saveRoleMenus(@Param("Id") Long id, @Param("menus") Set<Menu> menus);

    void dropRoleMenus(@Param("Id") Long roleId);

    void dropRoleUsers(@Param("Id") Long roleId);
}