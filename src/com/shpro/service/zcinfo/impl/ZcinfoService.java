package com.shpro.service.zcinfo.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.util.PageData;
import com.shpro.service.zcinfo.ZcinfoManager;

/** 
 * ??? ????????
 * ????Q351412933
 * ?????2019-03-09
 * @version
 */
@Service("zcinfoService")
public class ZcinfoService implements ZcinfoManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**??
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception{
		dao.save("ZcinfoMapper.save", pd);
	}
	
	/**??
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception{
		dao.delete("ZcinfoMapper.delete", pd);
	}
	
	/**??
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception{
		dao.update("ZcinfoMapper.edit", pd);
	}
	
	/**??
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("ZcinfoMapper.datalist", page);
	}
	
	/**??(??)
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("ZcinfoMapper.listAll", pd);
	}
	
	/**??id????
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("ZcinfoMapper.findById", pd);
	}
	
	public PageData findByOpenId(PageData pd)throws Exception{
		return (PageData)dao.findForObject("ZcinfoMapper.findByOpenId", pd);
	}
	
	public PageData findParam(PageData pd)throws Exception{
		return (PageData)dao.findForObject("ZcinfoMapper.findParam", pd);
	}
	
	/**????
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("ZcinfoMapper.deleteAll", ArrayDATA_IDS);
	}
	
}

