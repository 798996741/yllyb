package com.shpro.service.zcinfo;

import java.util.List;

import com.fh.entity.Page;
import com.fh.util.PageData;

/** 
 * ??? ??????????
 * ????FH Q351412933
 * ?????2019-03-09
 * @version
 */
public interface ZcinfoManager{

	/**??
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception;
	
	/**??
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception;
	
	/**??
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception;
	
	public PageData findByOpenId(PageData pd)throws Exception;
	
	/**??
	 * @param page
	 * @throws Exception
	 */
	public List<PageData> list(Page page)throws Exception;
	
	/**??(??)
	 * @param pd
	 * @throws Exception
	 */
	public List<PageData> listAll(PageData pd)throws Exception;
	
	/**??id????
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception;
	
	/**????
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception;
	
	public PageData findParam(PageData pd)throws Exception;
	
}

