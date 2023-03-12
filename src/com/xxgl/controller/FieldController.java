package com.xxgl.controller;

import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.shiro.session.Session;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.entity.system.CaseBean;
import com.fh.entity.system.Dictionaries;
import com.fh.entity.system.User;
import com.fh.service.system.dictionaries.DictionariesManager;
import com.fh.util.AppUtil;
import com.fh.util.Const;
import com.fh.util.Jurisdiction;
import com.fh.util.ObjectExcelView;
import com.fh.util.PageData;
import com.xxgl.service.mng.CaseManager;
import com.xxgl.service.mng.FieldDetailManager;
import com.xxgl.service.mng.FieldManager;


/** 
 * 说明：参数配置表
 * 创建人：351412933
 * 创建时间：2018-07-06
 */
@Controller
@RequestMapping(value="/field")
public class FieldController extends BaseController {
	
	String menuUrl = "field/list.do"; //菜单地址(权限用)
	@Resource(name="fielddetailService")
	private FieldDetailManager fieldDetailService;
	
	@Resource(name="fieldService")
	private FieldManager fieldService;
	@Resource(name="caseService")
	private CaseManager caseService;
	@Resource(name="dictionariesService")
	private DictionariesManager dictionariesService;
	/**保存
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	public ModelAndView save() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"新增Field");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		
		pd = this.getPageData();
		pd.put("FIELD_ID", this.get32UUID());	//主键
		pd.put("CZMAN", Jurisdiction.getUsername());
		String UID=pd.getString("UID")==null?"":pd.getString("UID");
		String fieldstr=pd.getString("fieldstr")==null?"":pd.getString("fieldstr");
		String addrstr=pd.getString("addrstr")==null?"":pd.getString("addrstr");
		String maxstr=pd.getString("maxstr")==null?"":pd.getString("maxstr");
		String minstr=pd.getString("minstr")==null?"":pd.getString("minstr");
		String remarkstr=pd.getString("remarkstr")==null?"":pd.getString("remarkstr");
		String[] fieldarr=fieldstr.split(",");
		String[] addrarr=addrstr.split(",");
		String[] maxarr=maxstr.split(",");
		String[] minarr=minstr.split(",");
		String[] remarkarr=remarkstr.split(",");
		String field="",addr="",max="",min="",remark="";
		PageData pd_add = new PageData();
		fieldDetailService.delete(pd);//删出UID信息
		
		for(int i=0;i<fieldarr.length;i++){
			pd_add = new PageData();
			field=fieldarr[i];
			addr=addrarr[i];if(addr!=null&&addr.equals("OOOOOOOOOO")){addr="";}
			max=maxarr[i];if(max!=null&&max.equals("OOOOOOOOOO")){max="";}
			min=minarr[i];if(min!=null&&min.equals("OOOOOOOOOO")){min="";}
			remark=remarkarr[i];if(remark!=null&&remark.equals("OOOOOOOOOO")){remark="";}
			pd_add.put("UID", UID);
			pd_add.put("FIELD", field);
			pd_add.put("ADDR", addr);
			pd_add.put("MAX", max);
			pd_add.put("MIN", min);
			pd_add.put("REMARK", remark);
			if(!field.equals("")){
				fieldDetailService.save(pd_add);//删出UID信息
			}
		}
		
		
		fieldService.save(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		mv.setViewName("xxgl/field/field_list");
		return mv;
	}
	
	/**删除
	 * @param out
	 * @throws Exception
	 */
	@RequestMapping(value="/delete")
	public void delete(PrintWriter out) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"删除Field");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		fieldService.delete(pd);
		fieldDetailService.delete(pd);//删出UID信息
		out.write("success");
		out.close();
	}
	
	/**修改
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")
	public ModelAndView edit() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改Field");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("CZMAN", Jurisdiction.getUsername());
		String UID=pd.getString("UID")==null?"":pd.getString("UID");
		String fieldstr=pd.getString("fieldstr")==null?"":pd.getString("fieldstr");
		String addrstr=pd.getString("addrstr")==null?"":pd.getString("addrstr");
		String maxstr=pd.getString("maxstr")==null?"":pd.getString("maxstr");
		String minstr=pd.getString("minstr")==null?"":pd.getString("minstr");
		String remarkstr=pd.getString("remarkstr")==null?"":pd.getString("remarkstr");
		String[] fieldarr=fieldstr.split(",");
		String[] addrarr=addrstr.split(",");
		String[] maxarr=maxstr.split(",");
		String[] minarr=minstr.split(",");
		String[] remarkarr=remarkstr.split(",");
		String field="",addr="",max="",min="",remark="";
		PageData pd_add = new PageData();
		fieldDetailService.delete(pd);//删出UID信息
		
		for(int i=0;i<fieldarr.length;i++){
			pd_add = new PageData();
			field=fieldarr[i];
			addr=addrarr[i];if(addr!=null&&addr.equals("OOOOOOOOOO")){addr="";}
			max=maxarr[i];if(max!=null&&max.equals("OOOOOOOOOO")){max="";}
			min=minarr[i];if(min!=null&&min.equals("OOOOOOOOOO")){min="";}
			remark=remarkarr[i];if(remark!=null&&remark.equals("OOOOOOOOOO")){remark="";}
			pd_add.put("UID", UID);
			pd_add.put("FIELD", field);
			pd_add.put("ADDR", addr);
			pd_add.put("MAX", max);
			pd_add.put("MIN", min);
			pd_add.put("REMARK", remark);
			if(!field.equals("")){
				fieldDetailService.save(pd_add);//删出UID信息
			}
			
		}
		
		fieldService.edit(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/list")
	public ModelAndView list(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"列表Field");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords");				//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		page.setPd(pd);
		Session session = Jurisdiction.getSession();
	    User user=(User) session.getAttribute(Const.SESSION_USER);
	
		PageData pd_new = new PageData();
		String role_id=user.getROLE_ID();
	    if(role_id!=null&&role_id.equals("1")){
	    	  
	    }else{
	    	pd_new.put("USERNAME", user.getUSERNAME()); 
	    	pd.put("USERNAME", user.getUSERNAME()); 
	    }
		List<CaseBean> listcase = new ArrayList();
	    listcase=caseService.listAllCasetoEndpoint(pd_new);
	    mv.addObject("listcase_s", listcase);
		
		
		List<PageData>	varList = fieldService.list(page);	//列出Field列表
		mv.setViewName("xxgl/field/field_list");
		mv.addObject("varList", varList);
		mv.addObject("pd", pd);
		mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
		return mv;
	}
	
	/**去新增页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goAdd")
	public ModelAndView goAdd()throws Exception{
		ModelAndView mv = this.getModelAndView();
		Session session = Jurisdiction.getSession();
	     User user=(User) session.getAttribute(Const.SESSION_USER);
		PageData pd = new PageData();
		PageData pd_new = new PageData();
		String role_id=user.getROLE_ID();
	    if(role_id!=null&&role_id.equals("1")){
	    	  
	    }else{
	    	pd_new.put("USERNAME", user.getUSERNAME()); 
	    	pd.put("USERNAME", user.getUSERNAME()); 
	    }
		List<CaseBean> listcase = new ArrayList();
	    listcase=caseService.listAllCasetoEndpoint(pd_new);
	    mv.addObject("listcase", listcase);

	    List<Dictionaries> dictList=dictionariesService.listAllDict("2f0472d2e0dd4c668704abd1940f2905");
	    mv.addObject("dictList", dictList);
	    
	    List<Dictionaries> dictList_zd=dictionariesService.listAllDict("6b272abc46a34105ac98bb03dd71a549");
	    mv.addObject("dictList_zd", dictList_zd); 
	    String UID=this.get32UUID();
	
	//System.out.println(pd.getString("ADDR1")+"dd");
	//mv.addObject("varOList", varOList);
	    mv.addObject("UID", UID);
	    
		pd = this.getPageData();
		mv.setViewName("xxgl/field/field_edit");
		mv.addObject("msg", "save");
		mv.addObject("pd", pd);
		return mv;
	}	
	
	 /**去修改页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goEdit")
	public ModelAndView goEdit()throws Exception{
		ModelAndView mv = this.getModelAndView();
		Session session = Jurisdiction.getSession();
	     User user=(User) session.getAttribute(Const.SESSION_USER);
		PageData pd = new PageData();
		PageData pd_new = new PageData();
		String role_id=user.getROLE_ID();
	    if(role_id!=null&&role_id.equals("1")){
	    	  
	    }else{
	    	pd_new.put("USERNAME", user.getUSERNAME()); 
	    	pd.put("USERNAME", user.getUSERNAME()); 
	    }
		List<CaseBean> listcase = new ArrayList();
	    listcase=caseService.listAllCasetoEndpoint(pd_new);
	    mv.addObject("listcase", listcase);

	    List<Dictionaries> dictList=dictionariesService.listAllDict("2f0472d2e0dd4c668704abd1940f2905");
	    mv.addObject("dictList", dictList); 
	    
	    List<Dictionaries> dictList_zd=dictionariesService.listAllDict("6b272abc46a34105ac98bb03dd71a549");
	    mv.addObject("dictList_zd", dictList_zd); 
	    
	    
		pd = this.getPageData();
		pd = fieldService.findById(pd);	//根据ID读取
		
		
		String UID="";
		if(pd!=null&&(pd.getString("UID")!=null&&!pd.getString("UID").equals(""))){
			UID=pd.getString("UID");
			List<PageData> varOList = fieldDetailService.listAll(pd);
			String  ADDR="",MAX="",MIN="",REMARK="";
			for(int i=0;i<varOList.size();i++){
				//System.out.println(pd.getString("ADDR1")+"dd");
				//ADDR="ADDR"+i;
				//pd.put("ADDR1", varOList.get(i).getString("ADDR"));
				pd.put("ADDR"+(i+1)+"", varOList.get(i).getString("ADDR"));	    //3
				pd.put("MAX"+(i+1)+"", varOList.get(i).getString("MAX"));	    //4
				pd.put("MIN"+(i+1)+"", varOList.get(i).getString("MIN"));	    //5
				pd.put("REMARK"+(i+1)+"", varOList.get(i).getString("REMARK"));	
			}
		}else{
			UID=this.get32UUID();
		}
		//System.out.println(pd.getString("ADDR1")+"dd");
		//mv.addObject("varOList", varOList);
		mv.addObject("UID", UID);
		mv.setViewName("xxgl/field/field_edit");
		mv.addObject("msg", "edit");
		mv.addObject("pd", pd);
		return mv;
	}	
	
	 /**批量删除
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/deleteAll")
	@ResponseBody
	public Object deleteAll() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"批量删除Field");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String DATA_IDS = pd.getString("DATA_IDS");
		if(null != DATA_IDS && !"".equals(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			fieldService.deleteAll(ArrayDATA_IDS);
			pd.put("msg", "ok");
		}else{
			pd.put("msg", "no");
		}
		pdList.add(pd);
		map.put("list", pdList);
		return AppUtil.returnObject(pd, map);
	}
	
	 /**导出到excel
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/excel")
	public ModelAndView exportExcel() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"导出Field到excel");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String,Object> dataMap = new HashMap<String,Object>();
		List<String> titles = new ArrayList<String>();
		titles.add("起始地址");	//1
		titles.add("字段数量");	//2
		titles.add("实例id");	//3
		titles.add("类型");	//4
		titles.add("字段1");	//5
		titles.add("字段2");	//6
		titles.add("字段3");	//7
		titles.add("字段4");	//8
		titles.add("字段5");	//9
		titles.add("字段6");	//10
		dataMap.put("titles", titles);
		List<PageData> varOList = fieldService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<varOList.size();i++){
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).getString("STARTADDR"));	    //1
			vpd.put("var2", varOList.get(i).getString("NUM"));	    //2
			vpd.put("var3", varOList.get(i).getString("CASEID"));	    //3
			vpd.put("var4", varOList.get(i).getString("TYPE"));	    //4
			vpd.put("var5", varOList.get(i).getString("FIELD1"));	    //5
			vpd.put("var6", varOList.get(i).getString("FIELD2"));	    //6
			vpd.put("var7", varOList.get(i).getString("FIELD3"));	    //7
			vpd.put("var8", varOList.get(i).getString("FIELD4"));	    //8
			vpd.put("var9", varOList.get(i).getString("FIELD5"));	    //9
			vpd.put("var10", varOList.get(i).getString("FIELD6"));	    //10
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
