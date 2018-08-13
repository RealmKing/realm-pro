package com.realmcloud.admin.entity;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.activerecord.Model;
import com.baomidou.mybatisplus.annotations.TableName;
import com.realmcloud.admin.base.DataEntity;

/**
 * <p>
 * 产品基础信息
 * </p>
 *
 * @author realm
 * @since 2018-07-09
 */
@TableName("erp_pro_product")
public class ErpProProduct extends DataEntity<ErpProProduct> {

    private static final long serialVersionUID = 1L;

    /**
     * 产品ID
     */
	@TableField("product_id")
	private String productId;
    /**
     * 产品名称
     */
	@TableField("product_name")
	private String productName;
    /**
     * 产品型号
     */
	@TableField("product_version")
	private String productVersion;
    /**
     * 计量单位
     */
	@TableField("product_unit")
	private String productUnit;
    /**
     * 品牌
     */
	@TableField("product_brand")
	private String productBrand;
    /**
     * 产地所属省
     */
	@TableField("product_province")
	private String productProvince;
    /**
     * 所属市
     */
	@TableField("product_city")
	private String productCity;
    /**
     * 所属国家
     */
	@TableField("product_nation")
	private String productNation;

	/**
	 * 详细地址
	 */
	@TableField("product_address")
	private String productAddress;

	public String getProductId() {
		return productId;
	}

	public void setProductId(String productId) {
		this.productId = productId;
	}
	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}
	public String getProductVersion() {
		return productVersion;
	}

	public void setProductVersion(String productVersion) {
		this.productVersion = productVersion;
	}
	public String getProductUnit() {
		return productUnit;
	}

	public void setProductUnit(String productUnit) {
		this.productUnit = productUnit;
	}
	public String getProductBrand() {
		return productBrand;
	}

	public void setProductBrand(String productBrand) {
		this.productBrand = productBrand;
	}
	public String getProductProvince() {
		return productProvince;
	}

	public void setProductProvince(String productProvince) {
		this.productProvince = productProvince;
	}
	public String getProductCity() {
		return productCity;
	}

	public void setProductCity(String productCity) {
		this.productCity = productCity;
	}
	public String getProductNation() {
		return productNation;
	}

	public void setProductNation(String productNation) {
		this.productNation = productNation;
	}
	public String getProductAddress() {
		return productAddress;
	}

	public void setProductAddress(String productAddress) {
		this.productAddress = productAddress;
	}

	@Override
	public String toString() {
		return "ErpProProduct{" +
			", productId=" + productId +
			", productName=" + productName +
			", productVersion=" + productVersion +
			", productUnit=" + productUnit +
			", productBrand=" + productBrand +
			", productProvince=" + productProvince +
			", productCity=" + productCity +
			", productNation=" + productNation +
			", productNation=" + productAddress +
			"}";
	}
}
