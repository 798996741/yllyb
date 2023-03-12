package com.shpro.service.areamanage.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.shpro.entity.AreaManage;
import com.fh.util.PageData;
import com.shpro.service.areamanage.AreaManageManager;

/** 
 * 说明： 地区管理
 * 创建人：351412933
 * 创建时间：2018-10-09
 * @version
 */
@Service("areamanageService")
public class AreaManageService implements AreaManageManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception{
		dao.save("AreaManageMapper.save", pd);
	}
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception{
		dao.delete("AreaManageMapper.delete", pd);
	}
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception{
		dao.update("AreaManageMapper.edit", pd);
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("AreaManageMapper.datalistPage", page);
	}
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("AreaManageMapper.listAll", pd);
	}
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("AreaManageMapper.findById", pd);
	}
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findByAreaCode(PageData pd)throws Exception{
		return (PageData)dao.findForObject("AreaManageMapper.findByAreaCode", pd);
	}

	/**
	 * 通过AREA_CODE获取其子级列表
	 * @param parentId
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<AreaManage> listByParentId(String parentId) throws Exception {
		return (List<AreaManage>) dao.findForList("AreaManageMapper.listByParentId", parentId);
	}
	
	@SuppressWarnings("unchecked")
	public List<AreaManage> listByAreaCode(String areaCode) throws Exception {
		return (List<AreaManage>) dao.findForList("AreaManageMapper.listByAreaCode", areaCode);
	}
	
	/**
	 * 获取所有数据并填充每条数据的子级列表(递归处理)
	 * @param MENU_ID
	 * @return
	 * @throws Exception
	 */
	public List<AreaManage> listTree(String parentId, String action) throws Exception {
		List<AreaManage> valueList = this.listByParentId(parentId);
		for(AreaManage fhentity : valueList){
			if("hospital".equals(action)){
				fhentity.setSubAreaManage(this.listTree(fhentity.getAREA_ID(), action));
				fhentity.setTarget("treeFrame");
			}else{
				fhentity.setTreeurl("areamanage/list.do?AREA_ID="+fhentity.getAREA_ID());
				fhentity.setSubAreaManage(this.listTree(fhentity.getAREA_ID(), ""));
				fhentity.setTarget("treeFrame");
			}
		}
		return valueList;
	}
	
	/**
	 * 获取所有数据并填充每条数据的子级列表(递归处理)
	 * @param MENU_ID
	 * @return
	 * @throws Exception
	 */
	public List<AreaManage> listTreeSelf(String parentId, String action, int count) throws Exception {
		List<AreaManage> valueList = null;
		if(count == 1){
			valueList = this.listByAreaCode(parentId);
			for(AreaManage fhentity : valueList){
				if("hospital".equals(action)){
					count++;
					fhentity.setSubAreaManage(this.listTreeSelf(fhentity.getAREA_ID(), action, count));
					fhentity.setTarget("treeFrame");
				}else{
					count++;
					fhentity.setTreeurl("areamanage/list.do?AREA_ID="+fhentity.getAREA_ID());
					fhentity.setSubAreaManage(this.listTreeSelf(fhentity.getAREA_ID(), "", count));
					fhentity.setTarget("treeFrame");
				}
			}
		}else{
			valueList = this.listByParentId(parentId);
			for(AreaManage fhentity : valueList){
				if("hospital".equals(action)){
					fhentity.setSubAreaManage(this.listTreeSelf(fhentity.getAREA_ID(), action, count));
					fhentity.setTarget("treeFrame");
				}else{
					fhentity.setTreeurl("areamanage/list.do?AREA_ID="+fhentity.getAREA_ID());
					fhentity.setSubAreaManage(this.listTreeSelf(fhentity.getAREA_ID(), "", count));
					fhentity.setTarget("treeFrame");
				}
			}
		}
		return valueList;
	}
}

