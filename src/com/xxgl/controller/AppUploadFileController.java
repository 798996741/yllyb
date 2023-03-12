package com.xxgl.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.io.Writer;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;










import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.entity.system.Role;
import com.fh.service.system.user.UserManager;
import com.fh.util.AppUtil;
import com.fh.util.Const;
import com.fh.util.FilecopyHtml;
import com.fh.util.Jurisdiction;
import com.fh.util.MD5;
import com.fh.util.ObjectExcelView;
import com.fh.util.PageData;
import com.fh.util.StringUtils;
import com.fh.util.ZipTools;
import com.xxgl.service.mng.AppUploadFileManager;

import freemarker.template.Configuration;
import freemarker.template.Template;

/** 
 * ??????
 * ????351412933
 * ?????2018-08-01
 */
@Controller
@RequestMapping(value="/appUploadFile")
public class AppUploadFileController extends BaseController {
	
	String menuUrl = "appUploadFile/list.do"; //????(???)
	@Resource(name="appUploadFileService")
	private AppUploadFileManager appUploadFileService;
	@Resource(name="userService")
	private UserManager userService;
	
	/**??
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	public ModelAndView save() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"??appuploadfile");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //????
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("appuploadfile_ID", this.get32UUID());	//??
		appUploadFileService.save(pd);
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
		logBefore(logger, Jurisdiction.getUsername()+"??appuploadfile");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //????
		PageData pd = new PageData();
		pd = this.getPageData();
		appUploadFileService.delete(pd);
		out.write("success");
		out.close();
	}
	
	/**??
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")
	public ModelAndView edit() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"??appuploadfile");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //????
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		appUploadFileService.edit(pd);
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
		logBefore(logger, Jurisdiction.getUsername()+"??appuploadfile");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //????(???????????,???????????????????,??????????????)
		String ucode=Jurisdiction.getUsername();
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		
		pd = this.getPageData();
		String keywords = pd.getString("keywords");				//???????
		String lastEnd=pd.getString("lastEnd");
		String lastStart=pd.getString("lastStart");
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");//??????
		//System.out.println(df.format(new Date()));
		String startTime=df.format(new Date());
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		if(null != lastEnd && !"".equals(lastEnd)){
			pd.put("lastEnd", lastEnd+" 23:59:59");
		}
		if(null == lastStart || "".equals(lastStart)){
			pd.put("lastStart", startTime);
		}
		if(null == lastEnd || "".equals(lastEnd)){
			lastEnd=startTime;
			pd.put("lastEnd", startTime+" 23:59:59");
		}
		
		
	
		
//		if(null != ucode && !"".equals(ucode)&& !"admin".equals(ucode)){
//			//pd.put("ucode", ucode.trim());
//		}
//		pd.put("USERNAME", Jurisdiction.getUsername());
//
//		PageData pduser= userService.findByUsername(pd);
//
//		if(pduser!=null&&pduser.getString("DEVUSERS")!=null){
//			System.out.println("DEV:"+pduser.getString("DEVUSERS"));
//			pd.put("DEVUSERS", pduser.getString("DEVUSERS"));
//		}
//		List<PageData> userList=appUploadFileService.listDevUsers(pd);
//		mv.addObject("userList", userList);
		page.setPd(pd);
		String baseurl=Const.getUrl();
		pd.put("baseurl", baseurl);
		List<PageData>	varList = appUploadFileService.list(page);	//??appuploadfile??
		mv.setViewName("xxgl/appuploadfile/appuploadfile_list");
//		System.out.println(page.getPageStr()+"pagestr");
		mv.addObject("varList", varList);
		pd.put("lastEnd", lastEnd==null?"":lastEnd);
		mv.addObject("pd", pd);
		mv.addObject("QX",Jurisdiction.getHC());	//????
		return mv;
	}
	
	
	@RequestMapping(value="/listTj")
	public ModelAndView listTj(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"??appuploadfile");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //????(???????????,???????????????????,??????????????)
		String ucode=Jurisdiction.getUsername();
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords");				//???????
		String lastEnd=pd.getString("lastEnd");
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		if(null != lastEnd && !"".equals(lastEnd)){
			pd.put("lastEnd", lastEnd+" 23:59:59");
		}
		if(null != ucode && !"".equals(ucode)&& !"admin".equals(ucode)){
			//pd.put("ucode", ucode.trim());
		}
		pd.put("USERNAME", Jurisdiction.getUsername());
		PageData pduser= userService.findByUsername(pd);
		if(pduser!=null&&pduser.getString("DEVUSERS")!=null){
			pd.put("DEVUSERS", pduser.getString("DEVUSERS"));
		}
		List<PageData> userList=appUploadFileService.listDevUsers(pd);
		page.setPd(pd);
		String baseurl=Const.getUrl();
		pd.put("baseurl", baseurl);
		List<PageData>	varList = appUploadFileService.listTj(page);	//??appuploadfile??
		String allsum="0";
		long time=0;
		for(int i=0;i<varList.size();i++){
			
			allsum=String.valueOf(varList.get(i).getString("allsum"));
			allsum=allsum.replace(".0", "");

            time=Long.parseLong(allsum);

//            long hour = time/(60*60*1000);
//	        long minute = (time - hour*60*60*1000)/(60*1000);
//	        long second = (time - hour*60*60*1000 - minute*60*1000)/1000;

			String timeStr = null;
			String hour = null;
			String minute = null;
			String second = null;

			long hh = time/3600;
			if (hh < 10) {
				hour = "0" + hh;
			} else {
				hour = String.valueOf(hh);
			}
			long mm = (time - hh*3600)/60;
			if (mm < 10) {
				minute = "0" + mm;
			} else {
				minute = String.valueOf(mm);
			}
			long ss = (time - hh*3600)%60;
			if (ss < 10) {
				second = "0" + ss;
			} else {
				second = String.valueOf(ss);
			}
	        varList.get(i).put("allsum", (hour+ ":" + minute + ":" + second));
			
		}	
		mv.setViewName("xxgl/appuploadfile/appuploadfile_tj");
		System.out.println(varList);
		mv.addObject("varList", varList);
		pd.put("lastEnd", lastEnd==null?"":lastEnd);
		mv.addObject("pd", pd);
		mv.addObject("userList", userList);
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
		mv.setViewName("xxgl/appuploadfile/appuploadfile_edit");
		mv.addObject("msg", "save");
		mv.addObject("pd", pd);
		return mv;
	}	
	
	@RequestMapping(value="/dev_list")
	public ModelAndView dev_list(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"??appuploadfile");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //????(???????????,???????????????????,??????????????)
		String ucode=Jurisdiction.getUsername();
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords");				//???????
		
		if(null != ucode && !"".equals(ucode)&& !"admin".equals(ucode)){
			//pd.put("ucode", ucode.trim());
		}
		pd.put("USERNAME", Jurisdiction.getUsername());
		PageData pduser= userService.findByUsername(pd);
		if(pduser!=null&&pduser.getString("DEVUSERS")!=null){
			pd.put("DEVUSERS", pduser.getString("DEVUSERS"));
		}
		page.setPd(pd);
		List<PageData>	varList = appUploadFileService.datalistDevUsers(page);	//??appuploadfile??
		String allsum="0";
		long time=0;
		for(PageData pds:varList){
			if(pds.get("yxdate")!=null&&String.valueOf(pds.get("yxdate")).length()>=10){
				pds.put("yxdate", String.valueOf(pds.get("yxdate")).substring(0, 10));
			}
		}
		
	
		mv.setViewName("xxgl/appuploadfile/dev_list");
		//System.out.println(varList);
		mv.addObject("varList", varList);
		mv.addObject("pd", pd);
		mv.addObject("QX",Jurisdiction.getHC());	//????
		return mv;
	}
	
	
	@RequestMapping(value="/goAddDev")
	public ModelAndView goAddDev()throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		mv.setViewName("xxgl/appuploadfile/dev_edit");
		mv.addObject("msg", "saveDev");
		mv.addObject("pd", pd);
		return mv;
	}	
	
	/**??
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/saveDev")
	public ModelAndView saveDev() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"??Dev");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //????
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("czman",  Jurisdiction.getUsername());	//??
		if(pd.getString("upwd")!=null&&!pd.getString("upwd").equals("")){
			System.out.println(pd.getString("upwd")+"pwd");
			pd.put("upwd", MD5.md5(pd.getString("upwd")));
		}
		if(pd.getString("uid")!=null&&!pd.getString("uid").equals("")){
			appUploadFileService.editDevuser(pd);
		}else{
			appUploadFileService.saveDevuser(pd);
		}
		
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	@RequestMapping(value="/goEditDev")
	public ModelAndView goEditDev() throws Exception{
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //????
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd = appUploadFileService.findByUid(pd);	//??ID??
		if(pd.get("yxdate")!=null&&String.valueOf(pd.get("yxdate")).length()>=10){
			pd.put("yxdate", String.valueOf(pd.get("yxdate")).substring(0, 10));
		}
		mv.setViewName("xxgl/appuploadfile/dev_edit");
		mv.addObject("msg", "saveDev");
		mv.addObject("pd", pd);
		return mv;
	}
	
	
	
	/**?????????
	 * @return
	 */
	@RequestMapping(value="/hasU")
	@ResponseBody
	public Object hasU(){
		Map<String,String> map = new HashMap<String,String>();
		String errInfo = "success";
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			if(appUploadFileService.findByUcode(pd) != null){
				errInfo = "error";
			}
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		map.put("result", errInfo);				//????
		return AppUtil.returnObject(new PageData(), map);
	}
	
	
	
	/**?????????
	 * @return
	 */
	@RequestMapping(value="/binddev")
	@ResponseBody
	public Object binddev(){
		Map<String,String> map = new HashMap<String,String>();
		String errInfo = "success";
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			pd.put("bindman", Jurisdiction.getUsername());
			appUploadFileService.bindDevuser(pd);
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		map.put("result", errInfo);				//????
		return AppUtil.returnObject(new PageData(), map);
	}
	
	
	
	/**??
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/devuser_list")
	public ModelAndView devuser_list(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"??devuser_list");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //????(???????????,???????????????????,??????????????)
		String ucode=Jurisdiction.getUsername();
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords");				//???????
		String lastEnd=pd.getString("lastEnd");
		String lastStart=pd.getString("lastStart");
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");//??????
		//System.out.println(df.format(new Date()));
		String startTime=df.format(new Date());
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
	
		if(null != ucode && !"".equals(ucode)&& !"admin".equals(ucode)){
			pd.put("ucode", ucode.trim());
		}
		
		
		page.setPd(pd);
		String baseurl=Const.getUrl();
		pd.put("baseurl", baseurl);
		List<PageData>	varList = appUploadFileService.datalistDevUsers(page);	//??appuploadfile??
		mv.setViewName("xxgl/appuploadfile/devuser_list");
		//System.out.println(varList);
		mv.addObject("varList", varList);
		pd.put("lastEnd", lastEnd==null?"":lastEnd);
		mv.addObject("pd", pd);
		mv.addObject("QX",Jurisdiction.getHC());	//????
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
		pd = appUploadFileService.findById(pd);	//??ID??
		String baseurl=Const.getUrl();
		//pd.put("baseurl", baseurl);
		if(pd!=null&&pd.getString("uploadfile")!=null){
			pd.put("uploadfile", baseurl+pd.getString("uploadfile"));
		}
		mv.setViewName("xxgl/appuploadfile/appuploadfile_edit");
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
		logBefore(logger, Jurisdiction.getUsername()+"????appuploadfile");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //????
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String DATA_IDS = pd.getString("DATA_IDS");
		if(null != DATA_IDS && !"".equals(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			appUploadFileService.deleteAll(ArrayDATA_IDS);
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
		logBefore(logger, Jurisdiction.getUsername()+"??appuploadfile?excel");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String,Object> dataMap = new HashMap<String,Object>();
		List<String> titles = new ArrayList<String>();
		titles.add("优惠卷标题");	//1
		titles.add("有效期");	//2
		titles.add("详情");	//3
		titles.add("使用范围");	//4
		titles.add("费用");	//5
		titles.add("优惠前费用");	//6
		titles.add("创建人");	//7
		titles.add("时间");	//8
		dataMap.put("titles", titles);
		List<PageData> varOList = appUploadFileService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<varOList.size();i++){
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).getString("TITLE"));	    //1
			vpd.put("var2", varOList.get(i).getString("TERM_VALIDITY"));	    //2
			vpd.put("var3", varOList.get(i).getString("DETAIL"));	    //3
			vpd.put("var4", varOList.get(i).getString("USESCOPE"));	    //4
			vpd.put("var5", varOList.get(i).getString("MONEY"));	    //5
			vpd.put("var6", varOList.get(i).getString("PRE_MONEY"));	    //6
			vpd.put("var7", varOList.get(i).getString("CREATEMAN"));	    //7
			vpd.put("var8", varOList.get(i).getString("CREATEDATE"));	    //8
			varList.add(vpd);
		}
		dataMap.put("varList", varList);
		ObjectExcelView erv = new ObjectExcelView();
		mv = new ModelAndView(erv,dataMap);
		return mv;
	}
	@RequestMapping(value="/download")
	public void download(HttpServletRequest request,HttpServletResponse response) throws Exception{
		//??????????
		FilecopyHtml filecopy=new FilecopyHtml();
		String rootPath = request.getRealPath("/")+"uploadFiles\\";
		String fileroot = 	 request.getRealPath("/");
		System.out.println(fileroot);
		//????????
		String parentPath = Jurisdiction.getUsername()+"_"+StringUtils.getDateTime("yyyyMMdd");
		File file_r = new File(rootPath+parentPath);
		//System.out.println(file_r.exists());
		if(file_r.exists()){
			System.gc();
			filecopy.delFile(file_r);
		}
		String fileName="",inputPath="",oldPath="",newPath="",url="";
		String id = request.getParameter("id")==null?"": request.getParameter("id");
		String[] ida=id.split(",");
		PageData pd = new PageData();
		for(int i=0;i<ida.length;i++){
			pd.put("ID", ida[i]);
			pd=appUploadFileService.findById(pd);

			//???????
			//System.out.println(bdzimgList);
			fileName = parentPath+".zip";
			inputPath = "\\download\\"+fileName;
			String root=rootPath+parentPath;
			File file = new File(rootPath+parentPath);
			if(!file.exists()){
				file.mkdirs();
			}
			if(pd.getString("uploadfile")!=null){
				url=pd.getString("uploadfile");
				System.out.println(url);
				oldPath=request.getRealPath("/")+pd.getString("uploadfile");
				//System.out.println(oldPath);
				//System.out.println(pd.getString("uploadfile"));
				newPath=root+"/"+url.substring(url.lastIndexOf("/")+1,url.length());
				System.out.println(oldPath);
				System.out.println(newPath);
				filecopy.copyFile(oldPath, newPath);
			}
		}

		ZipTools.compressFloderChangeToZip(rootPath+parentPath, rootPath, fileName);


		File downfile = new File(rootPath+fileName); // ?????????? 
		InputStream ins; 

		ins = new BufferedInputStream(new FileInputStream(downfile)); 

		byte[] buffer = new byte[ins.available()]; 
		ins.read(buffer); 
		ins.close(); 

		response.reset(); 
		response.addHeader("Content-Disposition", "attachment;filename="+ new String(downfile.getName().getBytes())); 
		response.addHeader("Content-Length", "" + downfile.length()); 
		OutputStream ous = new BufferedOutputStream(response.getOutputStream()); 
		response.setContentType("application/octet-stream"); 
		ous.write(buffer); 
		ous.flush(); 
		ous.close();
		ins.close();
		
	}
    @RequestMapping(value="/listext_list")
    public ModelAndView listext_list(Page page) throws Exception{
//        logBefore(logger, Jurisdiction.getUsername()+"??appuploadfile");
        //if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //????(???????????,???????????????????,??????????????)
        String ucode=Jurisdiction.getUsername();
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        page.setPd(pd);
        List<PageData> list = appUploadFileService.queryExtAlllistPage(page);

        mv.setViewName("xxgl/appuploadfile/ext_list");
        //System.out.println(page.getPageStr()+"pagestr");
        mv.addObject("varList", list);
        mv.addObject("pd", pd);
        mv.addObject("QX",Jurisdiction.getHC());	//????
        return mv;
    }

    @RequestMapping(value="/goEditext")
    public ModelAndView goEditext() throws Exception{
//        if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //????
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
		System.out.println(pd);
		pd = appUploadFileService.queryExtById(pd);	//??ID??

        mv.setViewName("xxgl/appuploadfile/ext_edit");
        mv.addObject("msg", "saveext");
        mv.addObject("pd", pd);
        return mv;
    }

    @RequestMapping(value="/saveext")
    public ModelAndView saveext() throws Exception{
//        logBefore(logger, Jurisdiction.getUsername()+"??ext");
//        if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //????
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        pd.put("czman",  Jurisdiction.getUsername());	//??
		System.out.println(pd);
		if(pd.getString("ID")!=null&&!pd.getString("ID").equals("")){
            appUploadFileService.updateExt(pd);
        }else{
            appUploadFileService.insertExt(pd);
        }

        mv.addObject("msg","success");
		mv.setViewName("xxgl/appuploadfile/ext_list");
        return mv;
    }
    @RequestMapping(value="/goAddext")
    public ModelAndView goAddext()throws Exception{
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        mv.setViewName("xxgl/appuploadfile/ext_edit");
        mv.addObject("msg", "saveext");
        mv.addObject("pd", pd);
        return mv;
    }
	@RequestMapping(value="/delext")
	public ModelAndView delext()throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		appUploadFileService.deleteExtById(pd);
		mv.setViewName("xxgl/appuploadfile/ext_list");
		mv.addObject("msg","success");
		mv.addObject("pd", pd);
		return mv;
	}
    @InitBinder
	public void initBinder(WebDataBinder binder){
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format,true));
	}
}
