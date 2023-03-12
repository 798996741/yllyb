package com.fh.entity;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class TreeNode implements Serializable {

	private String id;
	private String text;
	private String pid;
	private List<TreeNode> children;  
	
	public List<TreeNode> getChildren() {
		return children;
	}

	public void setChildren(List<TreeNode> children) {
		this.children = children;
	}

	public TreeNode(String id, String text, String pid){
		this.id = id;
		this.text = text;
		this.pid = pid;
	}
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getText() {
		return text;
	}
	public void setText(String text) {
		this.text = text;
	}
	
	

	public String getPid() {
		return pid;
	}

	

	public void setPid(String pid) {
		this.pid = pid;
	}

	

}
