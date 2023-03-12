package com.fh.util;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintStream;
import java.util.Enumeration;
import java.util.zip.ZipEntry;
import java.util.zip.ZipFile;

public class ZipDecompression
{
  public static void main(String[] args)
    throws IOException
  {
    decompression("d:/upload/wssq20120726.zip", "d:/upload/wssq20120726/");
  }
  
  /**
   * �༶�ļ��к��ļ�����
   * @param destFileName
   * @return
   */
  public static boolean CreateFile(String destFileName) {
		File file = new File(destFileName);
		if (file.exists()) {
			System.out.println("���������ļ�" + destFileName + "ʧ�ܣ�Ŀ���ļ��Ѵ��ڣ�");
			return false;
		}
		if (destFileName.endsWith(File.separator)) {
			System.out.println("���������ļ�" + destFileName + "ʧ�ܣ�Ŀ�겻����Ŀ¼��");
			return false;
		}
		if (!file.getParentFile().exists()) {
			System.out.println("Ŀ���ļ�����·�������ڣ�׼������������");
			if (!file.getParentFile().mkdirs()) {
				System.out.println("����Ŀ¼�ļ����ڵ�Ŀ¼ʧ�ܣ�");
				return false;
			}
		}
		// ����Ŀ���ļ�
		try {
			if (file.createNewFile()) {
				System.out.println("���������ļ�" + destFileName + "�ɹ���");
				return true;
			} else {
				System.out.println("���������ļ�" + destFileName + "ʧ�ܣ�");
				return false;
			}
		} catch (IOException e) {
			e.printStackTrace();
			System.out.println("���������ļ�" + destFileName + "ʧ�ܣ�");
			return false;
		}
	}

  public static void decompression(String zipFile, String destination)
    throws IOException
  {
    ZipFile zip = new ZipFile(zipFile);
    Enumeration en = zip.entries();
    ZipEntry entry = null;
    byte[] buffer = new byte[8192];
    int length = -1;
    InputStream input = null;
    BufferedOutputStream bos = null;
    File file = null;

    while (en.hasMoreElements()) {
      entry = (ZipEntry)en.nextElement();
      if (entry.isDirectory()) {
        System.out.println("directory");
      }
      else
      {
        input = zip.getInputStream(entry);
        file = new File(destination, entry.getName());
        System.out.println(file);
        if (!file.getParentFile().exists()) {
          file.getParentFile().mkdirs();
        }
        CreateFile(file.toString());
        bos = new BufferedOutputStream(new FileOutputStream(file));
        while (true)
        {
          length = input.read(buffer);
          if (length == -1) break;
          bos.write(buffer, 0, length);
        }
        bos.close();
        input.close();
      }
    }
    zip.close();
  }
}