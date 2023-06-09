package com.shpro.service.areamanage;

import java.util.List;

import com.fh.entity.Page;
import com.shpro.entity.AreaManage;
import com.fh.util.PageData;

/** 
 * 说明： 地区管理接口
 * 创建人：FH Q313596790
 * 创建时间：2018-10-09
 * @version
 */
public interface AreaManageManager{

	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception;
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception;
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception;
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	public List<PageData> list(Page page)throws Exception;
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	public List<PageData> listAll(PageData pd)throws Exception;
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception;
	
	/**通过AREA_CODE获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findByAreaCode(PageData pd)throws Exception;
	
	/**
	 * 通过ID获取其子级列表
	 * @param parentId
	 * @return
	 * @throws Exception
	 */
	public List<AreaManage> listByParentId(String parentId) throws Exception;
	
	public List<AreaManage> listByAreaCode(String areaCode) throws Exception;
	
	/**
	 * 获取所有数据并填充每条数据的子级列表(递归处理)
	 * @param MENU_ID
	 * @return
	 * @throws Exception
	 */
	public List<AreaManage> listTree(String parentId, String action) throws Exception;
	
	/**
	 * 获取所有数据并填充每条数据的子级列表(递归处理)
	 * @param MENU_ID
	 * @return
	 * @throws Exception
	 */
	public List<AreaManage> listTreeSelf(String parentId, String action, int count) throws Exception;
	
}

