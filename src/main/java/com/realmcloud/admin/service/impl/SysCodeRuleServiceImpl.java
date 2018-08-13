package com.realmcloud.admin.service.impl;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.realmcloud.admin.dao.SysCodeRuleDao;
import com.realmcloud.admin.entity.SysCodeRule;
import com.realmcloud.admin.service.SysCodeRuleService;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.CachePut;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.cache.annotation.Caching;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author realm
 * @since 2018-07-03
 */
@Service
@Transactional(readOnly = true, rollbackFor = Exception.class)
public class SysCodeRuleServiceImpl extends ServiceImpl<SysCodeRuleDao, SysCodeRule> implements SysCodeRuleService {

    @Caching(
            put = {@CachePut(value = "role",key = "'role_id_'+T(String).valueOf(#result.id)",condition = "#result.id != null and #result.id != 0")},
            evict = {@CacheEvict(value = "roleAll",key = "'roleAll'" )
    })
    @Transactional(readOnly = false, rollbackFor = Exception.class)
    @Override
    public SysCodeRule save(SysCodeRule sysCodeRule) {
        baseMapper.insert(sysCodeRule);
        return sysCodeRule;
    }

    @Cacheable(value = "role",key = "'role_id_'+T(String).valueOf(#id)",unless = "#result == null")
    @Override
    public SysCodeRule getById(Long id) {
        SysCodeRule role = baseMapper.selectById(id);
        return role;
    }

    @Caching(evict = {
            @CacheEvict(value = "role",key = "'role_id_'+T(String).valueOf(#role.id)" ),
            @CacheEvict(value = "roleAll",key = "'roleAll'" ),
            @CacheEvict(value = "user",allEntries=true ),
            @CacheEvict(value = "allMenus",allEntries = true)
    })
    @Transactional(readOnly = false, rollbackFor = Exception.class)
    @Override
    public void update(SysCodeRule sysCodeRule) {
        baseMapper.updateById(sysCodeRule);

    }

    @Caching(evict = {
            @CacheEvict(value = "role",key = "'role_id_'+T(String).valueOf(#role.id)" ),
            @CacheEvict(value = "roleAll",key = "'roleAll'" ),
            @CacheEvict(value = "user",allEntries=true )
    })
    @Transactional(readOnly = false, rollbackFor = Exception.class)
    @Override
    public void delete(SysCodeRule sysCodeRule) {
        sysCodeRule.setDelFlag(true);
        baseMapper.updateById(sysCodeRule);
    }

    @Override
    public Integer getNameCount(String name) {
        EntityWrapper<SysCodeRule> wrapper = new EntityWrapper<>();
        wrapper.eq("name",name);
        return baseMapper.selectCount(wrapper);
    }

    @Cacheable(value = "roleAll",key = "'roleAll'",unless = "#result == null or #result.size() == 0")
    @Override
    public List<SysCodeRule> selectAll() {
        EntityWrapper<SysCodeRule> wrapper = new EntityWrapper<>();
        wrapper.eq("del_flag",false);
        List<SysCodeRule> roleList = baseMapper.selectList(wrapper);
        return roleList;
    }
}
