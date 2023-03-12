package com.shpro.service.phone.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.util.PageData;
import com.shpro.service.phone.PhoneConnectManager;

/** 
 * 说明： 电话号专属号关联设置
 * 创建人：Q351412933
 * 创建时间：2019-04-26
 * @version
 */
@Service("phoneconnectService")
public class PhoneConnectService implements PhoneConnectManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception{
		dao.save("PhoneConnectMapper.save", pd);
	}
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception{
		dao.delete("PhoneConnectMapper.delete", pd);
	}
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception{
		dao.update("PhoneConnectMapper.edit", pd);
	}
	
	public void editSet(PageData pd)throws Exception{
		dao.update("PhoneConnectMapper.editSet", pd);
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("PhoneConnectMapper.datalist", page);
	}
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("PhoneConnectMapper.listAll", pd);
	}
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("PhoneConnectMapper.findById", pd);
	}
	
	public PageData findByNumber(PageData pd)throws Exception{
		return (PageData)dao.findForObject("PhoneConnectMapper.findByNumber", pd);
	}
	
	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("PhoneConnectMapper.deleteAll", ArrayDATA_IDS);
	}
	
}

