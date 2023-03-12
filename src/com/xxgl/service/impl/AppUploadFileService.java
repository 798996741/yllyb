package com.xxgl.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.util.PageData;
import com.xxgl.service.mng.AppUploadFileManager;

/** 
 * 说明： 优惠券
 * 创建人：351412933
 * 创建时间：2018-08-01
 * @version
 */
@Service("appUploadFileService")
public class AppUploadFileService implements AppUploadFileManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception{
		dao.save("AppUploadFileMapper.save", pd);
	}
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception{
		dao.delete("AppUploadFileMapper.delete", pd);
	}
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception{
		dao.update("AppUploadFileMapper.edit", pd);
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("AppUploadFileMapper.datalistPage", page);
	}
	
	@SuppressWarnings("unchecked")
	public List<PageData> listTj(Page page)throws Exception{
		return (List<PageData>)dao.findForList("AppUploadFileMapper.dataTj", page);
	}
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("AppUploadFileMapper.listAll", pd);
	}
	
	@SuppressWarnings("unchecked")
	public List<PageData> listDevUsers(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("AppUploadFileMapper.listDevUsers", pd);
	}
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("AppUploadFileMapper.findById", pd);
	}

	public PageData findByUid(PageData pd)throws Exception{
		return (PageData)dao.findForObject("AppUploadFileMapper.findByUid", pd);
	}
	
	public PageData findByUcode(PageData pd)throws Exception{
		return (PageData)dao.findForObject("AppUploadFileMapper.findByUcode", pd);
	}
	
	
	public void bindDevuser(PageData pd)throws Exception{
		dao.update("AppUploadFileMapper.bindDevuser", pd);
	}
	
	public void saveDevuser(PageData pd)throws Exception{
		dao.update("AppUploadFileMapper.saveDevuser", pd);
	}
	
	public void editDevuser(PageData pd)throws Exception{
		dao.update("AppUploadFileMapper.editDevuser", pd);
	}
	
	
	
	public PageData dataCount(PageData pd)throws Exception{
		return (PageData)dao.findForObject("AppUploadFileMapper.dataCount", pd);
	}
	
	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("AppUploadFileMapper.deleteAll", ArrayDATA_IDS);
	}
	
	
	@SuppressWarnings("unchecked")
	public List<PageData> datalistDevUsers(Page page)throws Exception{
		return (List<PageData>)dao.findForList("AppUploadFileMapper.datalistDevUsers", page);
	}

	@Override
	public PageData queryExtById(PageData pd) throws Exception {
		return (PageData)dao.findForObject("AppUploadFileMapper.queryExtById", pd);
	}

	@Override
	public List<PageData> queryExtAlllistPage(Page page) throws Exception {
		return (List<PageData>)dao.findForList("AppUploadFileMapper.queryExtAlllistPage", page);
	}

	@Override
	public void insertExt(PageData pd) throws Exception {
		dao.save("AppUploadFileMapper.insertExt",pd);
	}

	@Override
	public void updateExt(PageData pd) throws Exception {
		dao.update("AppUploadFileMapper.updateExt",pd);
	}

	@Override
	public void deleteExtById(PageData pd) throws Exception {
		dao.delete("AppUploadFileMapper.deleteExtById",pd);
	}

}

