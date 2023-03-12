package com.xxgl.service.mng;

import java.util.List;

import com.fh.entity.Page;
import com.fh.util.PageData;

/** 
 * 说明： 优惠券接口
 * 创建人：351412933
 * 创建时间：2018-08-01
 * @version
 */
public interface AppUploadFileManager{

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
	
	public List<PageData> listTj(Page page)throws Exception;
	
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	public List<PageData> listAll(PageData pd)throws Exception;
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	public List<PageData> listDevUsers(PageData pd)throws Exception;
	
	
	public PageData dataCount(PageData pd)throws Exception;
	
	
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception;
	
	public PageData findByUid(PageData pd)throws Exception;
	
	public PageData findByUcode(PageData pd)throws Exception;
	
	public void saveDevuser(PageData pd)throws Exception;
	
	public void editDevuser(PageData pd)throws Exception;
	
	public void bindDevuser(PageData pd)throws Exception;
	
	
	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception;
	
	public List<PageData> datalistDevUsers(Page page)throws Exception;

	public PageData queryExtById(PageData pd)throws Exception;
	public List<PageData> queryExtAlllistPage(Page page)throws Exception;
	public void insertExt(PageData pd)throws Exception;
	public void updateExt(PageData pd)throws Exception;
	public void deleteExtById(PageData pd)throws Exception;

}

