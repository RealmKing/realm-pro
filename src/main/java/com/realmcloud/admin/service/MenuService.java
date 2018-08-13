package com.realmcloud.admin.service;

import com.baomidou.mybatisplus.service.IService;
import com.realmcloud.admin.entity.Menu;
import com.realmcloud.admin.entity.User;
import com.realmcloud.admin.entity.VO.ShowMenu;
import com.realmcloud.admin.entity.VO.TreeMenu;
import com.realmcloud.admin.entity.VO.ZtreeVO;

import java.util.List;
import java.util.Map;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author realm
 * @since 2017-10-31
 */
public interface MenuService extends IService<Menu> {

    List<Menu> selectAllMenus(Map<String,Object> map);

    List<ZtreeVO> showTreeMenus();

    List<ShowMenu> getShowMenuByUser(Long id,Long parentId);

    void saveOrUpdateMenu(Menu menu);

    int getCountByPermission(String permission);

    int getCountByName(String name);

}
