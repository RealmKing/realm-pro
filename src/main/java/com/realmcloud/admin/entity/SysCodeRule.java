package com.realmcloud.admin.entity;


import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableName;
import com.realmcloud.admin.base.DataEntity;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * 编码规则主表
 *
 * @author realm
 */
@Getter
@Setter
@ToString
@TableName("sys_coderule")
public class SysCodeRule extends DataEntity<SysCodeRule> {


    /**
     * 编码名称
     */
    @Getter
    @Setter
    @TableField(value = "name")
    private String name;

    /**
     * 编码代号
     */
    @Getter
    @Setter
    @TableField(value = "code")
    private String code;

    /**
     * 删除标记
     */
    @Getter
    @Setter
    @TableField(value = "remark")
    private String remark;
}
