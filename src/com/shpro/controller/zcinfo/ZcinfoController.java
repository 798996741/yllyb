package com.shpro.controller.zcinfo;

import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.util.AppUtil;
import com.fh.util.ObjectExcelView;
import com.fh.util.PageData;
import com.fh.util.Jurisdiction;
import com.fh.util.Tools;
import com.shpro.service.zcinfo.ZcinfoManager;

/** 
 * ???????????
* ????FH Q351412933
 * ?????2019-03-09
 */
@Controller
@RequestMapping(value="/zcinfo")
public class ZcinfoController extends BaseController {
	
	String menuUrl = "zcinfo/list.do"; //????(???)
	@Resource(name="zcinfoService")
	private ZcinfoManager zcinfoService;
	
	/**??
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	public ModelAndView save() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"??zcinfo");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //????
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("WXUSER_ID", this.get32UUID());	//??
		zcinfoService.save(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**??
	 * @param out
	 * @throws Exception
	 */
	@RequestMapping(value="/delete")
	public void delete(PrintWriter out) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"??Wxuser");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //????
		PageData pd = new PageData();
		pd = this.getPageData();
		zcinfoService.delete(pd);
		out.write("success");
		out.close();
	}
	
	/**??
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")
	public ModelAndView edit() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"??Wxuser");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //????
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		zcinfoService.edit(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**??
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/list")
	public ModelAndView list(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"??Wxuser");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //????(???????????,???????????????????,??????????????)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords");				//???????
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		page.setPd(pd);
		List<PageData>	varList = zcinfoService.list(page);	//??Wxuser??
		mv.setViewName("zcinfo/zcinfo_list");
		mv.addObject("varList", varList);
		mv.addObject("pd", pd);
		mv.addObject("QX",Jurisdiction.getHC());	//????
		return mv;
	}
	
	/**?????
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goAdd")
	public ModelAndView goAdd()throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		mv.setViewName("zcinfo/zcinfo_edit");
		mv.addObject("msg", "save");
		mv.addObject("pd", pd);
		return mv;
	}	
	
	 /**?????
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goEdit")
	public ModelAndView goEdit()throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd = zcinfoService.findById(pd);	//??ID??
		mv.setViewName("zcinfo/zcinfo_edit");
		mv.addObject("msg", "edit");
		mv.addObject("pd", pd);
		return mv;
	}	
	
	 /**????
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/deleteAll")
	@ResponseBody
	public Object deleteAll() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"????zcinfo");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //????
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String DATA_IDS = pd.getString("DATA_IDS");
		if(null != DATA_IDS && !"".equals(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			zcinfoService.deleteAll(ArrayDATA_IDS);
			pd.put("msg", "ok");
		}else{
			pd.put("msg", "no");
		}
		pdList.add(pd);
		map.put("list", pdList);
		return AppUtil.returnObject(pd, map);
	}
	
	 /**???excel
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/excel")
	public ModelAndView exportExcel() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"??zcinfo?excel");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String,Object> dataMap = new HashMap<String,Object>();
		List<String> titles = new ArrayList<String>();
		titles.add("????");	//1
		titles.add("??/????");	//2
		titles.add("??");	//3
		titles.add("??");	//4
		titles.add("???");	//5
		titles.add("???");	//6
		titles.add("??");	//7
		titles.add("????");	//8
		titles.add("????");	//9
		titles.add("????");	//10
		titles.add("????");	//11
		titles.add("????????");	//12
		titles.add("????");	//13
		dataMap.put("titles", titles);
		List<PageData> varOList = zcinfoService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<varOList.size();i++){
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).getString("USERYTYPE"));	    //1
			vpd.put("var2", varOList.get(i).getString("NAME"));	    //2
			vpd.put("var3", varOList.get(i).getString("SEX"));	    //3
			vpd.put("var4", varOList.get(i).getString("AGE"));	    //4
			vpd.put("var5", varOList.get(i).getString("CITY"));	    //5
			vpd.put("var6", varOList.get(i).getString("AREA"));	    //6
			vpd.put("var7", varOList.get(i).getString("ADDRESS"));	    //7
			vpd.put("var8", varOList.get(i).getString("TEL"));	    //8
			vpd.put("var9", varOList.get(i).getString("JOB"));	    //9
			vpd.put("var10", varOList.get(i).getString("FOUDDATE"));	    //10
			vpd.put("var11", varOList.get(i).getString("CAPTAIL"));	    //11
			vpd.put("var12", varOList.get(i).getString("ZYJR"));	    //12
			vpd.put("var13", varOList.get(i).getString("ZCTIME"));	    //13
			varList.add(vpd);
		}
		dataMap.put("varList", varList);
		ObjectExcelView erv = new ObjectExcelView();
		mv = new ModelAndView(erv,dataMap);
		return mv;
	}
	
	@InitBinder
	public void initBinder(WebDataBinder binder){
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format,true));
	}
}
