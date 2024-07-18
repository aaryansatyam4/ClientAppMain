package com.digicode.util;

import java.awt.Color;
import java.awt.Font;
import java.awt.FontMetrics;
import java.awt.GradientPaint;
import java.awt.Graphics2D;
import java.awt.RenderingHints;
import java.awt.geom.AffineTransform;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.math.BigInteger;
import java.net.URISyntaxException;
import java.nio.charset.StandardCharsets;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.Key;
import java.security.KeyManagementException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.ResourceBundle;
import java.util.Set;
import java.util.UUID;
import java.util.regex.Matcher;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;
import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.codec.binary.Base64;
import org.apache.http.HttpException;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.utils.URIBuilder;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.logging.log4j.ThreadContext;
import org.bson.Document;

import com.google.common.base.Strings;
import com.google.gson.Gson;
import com.mongodb.client.MongoCursor;
import net.sf.json.JSONObject;
import net.sf.json.JSONSerializer;

/*
 */
@SuppressWarnings("deprecation")
public class Utility {


	private static final Logger log = LogManager.getLogger(Utility.class.getName());

	public static String toJsonString(String jsonObj) {
		log.debug("toJsonString called");
		return "\"" + jsonObj.replaceAll("\"", Matcher.quoteReplacement("\\\"")) + "\"";

	}

	// CREATE AFTER LOGIN OTP KEY
	public static String getAfterLoginOTPKey(String postSID) {
		return "afterLoginOTP@" + postSID;
	}

	// CREATE EDIT PROFILE OTP KEY
	public static String getEditProfileOTPKey(String postSID) {
		return "editProfileOTP@" + postSID;
	}

		public static JSONObject toJSON(String jsonStr) {
		log.debug("JSON String: " + jsonStr);
		return (JSONObject) JSONSerializer.toJSON(jsonStr);
	}

	// RETURN THE USER'S MACHINE IP ADDRESS
	public static String getIPAddress(HttpServletRequest request) {
		log.debug("getIpAddress called");

		String ipAddreass = "";
		if (request != null) {
			try {
				ipAddreass = request.getHeader("X-FORWARDED-FOR");
				if (ipAddreass == null) {
					ipAddreass = request.getRemoteAddr();
				}
			} catch (Exception ex) {
				ipAddreass = request.getRemoteAddr();
			}
		}
		log.debug("IPAddress: " + ipAddreass);
		return ipAddreass;
	}

	// RETURN THE USER AGENT STRING
	public static String getUserAgent(HttpServletRequest request) {
		// return request.getHeader("");
		return request.getHeader("user-agent").replaceAll("\\s", "");
		// return
		// "Mozilla/5.0(WindowsNT10.0;Win64;x64)AppleWebKit/537.36(KHTML,likeGecko)Chrome/83.0.4103.116Safari/537.36";
	}

	// RETURN CURRENT DATE WITH TIME
	public static String getCurrentDateTime() {
		SimpleDateFormat sdfDate = null;
		Calendar cal = null;
		Date now = null;
		try {
			log.debug("getCurrentDateTime called");
			sdfDate = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
			cal = GregorianCalendar.getInstance();
			now = new Date();
			cal.setTime(now);
			return sdfDate.format(cal.getTime());
		} finally {
			sdfDate = null;
			cal = null;
			now = null;
		}
		// cal.add(Calendar.HOUR_OF_DAY, 1);
		// cal.add(Calendar.MINUTE, Cookies.SESSION_EXPIRE_MINUTES_IN_MONGODB);

	}

	// RETURN CURRENT ISO DATE WITH TIME
	public static Date getISODateTime() {
		Date now = null;
		try {
			log.debug("getISODateTime called");
			now = new Date();

			return now;
		} finally {
			now = null;
		}
		// cal.add(Calendar.HOUR_OF_DAY, 1);
		// cal.add(Calendar.MINUTE, Cookies.SESSION_EXPIRE_MINUTES_IN_MONGODB);

	}

	// CREATE PRE LOGIN SESSION KEY
	public static String getPreLoginSessionKey(String preSID, String brwID, String userAgent) {
		return "preLoginSession@" + preSID + "@" + brwID + "@" + userAgent;
	}

	// CREATE POST LOGIN SESSION KEY
	public static String getPostLoginSessionKey(String postSID, String brwID, String userAgent) {
		return "postLoginSession@" + postSID + "@" + brwID + "@" + userAgent;
		// return postSID + "@" + pid + "@" + brwID + "@" + userAgent;
	}

	// GET LOGOUT CALL BACK KEY
	public static String getLogoutCallBackKey(String postSID, String brwID, String userAgent) {
		return "logoutCallBack@" + postSID + "@" + brwID + "@" + userAgent;
		// return postSID + "@" + pid + "@" + brwID + "@" + userAgent;
	}

	// CREATE BROWSER ID EXISTANCE KEY
	public static String getBrowserIdKey(String brwID) {
		return "browserId_" + brwID.charAt(brwID.length() - 1);
	}

	// CREATE BROWSER ID EXISTANCE KEY
	public static String getFingerPrintCollection(String brwID) {
		return ResourceBundle.getBundle("mongo").getString("BROWSER_FINGER_PRINT_COLLECTION")
				+ brwID.toUpperCase().charAt(0);
	}

	// CREATE POST LOGIN SESSION ID HASH BASED KEY
	public static String getPostLoginCollectionKey(String postSId) {
		return "postLoginSession_" + postSId.charAt(postSId.length() - 1);
	}

	// CREATE LOGIN OTP KEY
	public static String getOTPKey(String preSID) {
		return "otp@" + preSID;
	}

	// RETURN TIME OUT CASE OTP KEY
	public static String getTimeoutCaseOTPKey(String postSID) {
		return "timeoutotp@" + postSID;
	}

	// CREATE LOGIN OTP KEY
	public static String getChangePwdOTPKey(String postSID) {
		return "changePwdOTP@" + postSID;
	}

	// CREATE OTP COUNT KEY
	public static String getOTPCountKey(String preSID) {
		return "otpcount@" + preSID;
	}

	// CREATE LOGGED IN OTP KEY
	public static String getLoggedInOTPKey(String postSID) {
		return "loggedInOTP@" + postSID;
	}

	// CREATE SERVICE KEY FOR CURRENT DAY
	public static String getCurrentServiceKey(String serviceId, String userAgent) {
		return serviceId + "@" + userAgent;
	}

	// CREATE SERVICE KEY CORRESPONDING TO JANPARICHAY SERVICES COLLECTION
	public static String getRedisServiceKey(String serviceId) {
		log.debug("getRedisServiceKey called");
		return "janParichayService@serviceId@" + serviceId;
	}

	// RETURN RESPONSE OBJECT IN STRING FORM
	public static String getResponseObj(String status, String message, String statusCode, String pageName,
			JSONObject data) {
		log.debug("getResponseObj called");
		log.debug("Status: " + status + "\nMessage: " + message + "\nStatusCode: " + statusCode + "\nPageName: "
				+ pageName + "\nData: " + data);
		JSONObject responseJSON = new JSONObject();

		responseJSON.put("status", status);
		responseJSON.put("message", message);
		// responseJSON.put("statusCode", statusCode);
		responseJSON.put("pageName", pageName);
		responseJSON.put("data", data);

		// log.info("Response object: " + responseJSON);
		return responseJSON.toString();
	}


	// RETURN CLINET RESPONSE OBJECT IN STRING FORM
	public static String getClientResponseObj(JSONObject responseObj, String status, String message, String errorCode) {
		log.debug("getClientResponseObj called");
		log.debug("Status: " + status + "\nMessage: " + message + "\nErrorCode: " + errorCode);
		log.debug("Response object: " + responseObj);

		responseObj.put("Status", status);
		responseObj.put("Message", message);
		responseObj.put("ErrorCode", errorCode);

		log.info("Response JSON Object: " + responseObj);
		return responseObj.toString();
	}

	// // RETURN RESPONSE OBJECT IN STRING FORM
	// public static String getResponseObjForSendSeal(String status, String message,
	// String statusCode, String pageName,
	// String seal, JSONObject responseObj) throws Exception {
	// log.debug("getResponseObjForSendSeal method called with parameter Status: " +
	// status + "\nMessage: " + message
	// + "\nStatusCode: " + statusCode + "\nPageName: " + pageName + "\nSeal: " +
	// seal);
	// // JSONObject responseJSON = new JSONObject();
	//
	// responseObj.put("status", status);
	// responseObj.put("message", message);
	// // responseJSON.put("statusCode", statusCode);
	// responseObj.put("pageName", pageName);
	// responseObj.put("seal", seal);
	//
	// log.info("Response object: " + responseObj);
	// return responseObj.toString();
	// }

	// RETURN RESPONSE OBJECT IN STRING FORM
	public static String getResponseObjForSendSeal(String status, String message, String statusCode, String pageName,
			String seal, JSONObject responseObj) throws Exception {
		log.debug("getResponseObjForSendSeal method called with parameter Status: " + status + "\nMessage: " + message
				+ "\nStatusCode: " + statusCode + "\nPageName: " + pageName + "\nSeal: " + seal);

		JSONObject dataJSON = new JSONObject();
		try {
			dataJSON.put("hideFlag", "0");
			responseObj.put("status", status);
			responseObj.put("message", message);
			// responseJSON.put("statusCode", statusCode);
			responseObj.put("pageName", pageName);
			responseObj.put("data", dataJSON);
			responseObj.put("seal", seal);

		} finally {
			dataJSON = null;
		}
		log.info("Response object: " + responseObj);
		return responseObj.toString();
	}

	public static String encode(String input) {
		StringBuilder resultStr = new StringBuilder();

		for (char ch : input.toCharArray()) {
			if (isUnsafe(ch)) {
				resultStr.append('%');
				resultStr.append(toHex(ch / 16));
				resultStr.append(toHex(ch % 16));
			} else {
				resultStr.append(ch);
			}
		}
		return resultStr.toString();
	}

	// public static JSONObject getJSONFromString(String jsonString) throws
	// JSONException {
	// return new JSONObject(jsonString);
	//
	// }

	public static void showPopUp(HttpServletResponse response, String message) throws IOException {
		log.debug("showPopUp called");
		PrintWriter out = response.getWriter();
		out.print("<html><head>");
		out.print("<script type=\"text/javascript\">alert(" + message + ");</script>");
		out.print("</head><body></body></html>");
	}

	public static boolean isUnsafe(char ch) {
		// if (ch > 128 || ch < 0) {
		// return true;
		// }
		if (ch > 128) {
			return true;
		}

		try {
			if (Double.parseDouble(String.valueOf(ch)) < 0) {
				return true;
			}
		} catch (NumberFormatException e) {
			// System.out.println("String " + test1 + "is not a number");
		}

		return " %$&+,/:;=?@<>#%!^~`{}[]()-_\"\\*'|".indexOf(ch) >= 0;
	}

	public static char toHex(int ch) {
		return (char) (ch < 10 ? '0' + ch : 'A' + ch - 10);
	}

	public static boolean createDirectory(String folderNameWithFullPath) throws Exception {
		log.debug("createDirectory method called ");
		boolean status = false;

		File directory = new File(folderNameWithFullPath);
		// if the directory does not exist, create it
		if (directory.exists()) {
			log.debug("Directory already exists ...");
			status = true;

		} else {
			log.debug("Directory not exists, creating now");

			status = directory.mkdir();
			if (status) {
				log.debug("Successfully created new directory ");
			} else {
				log.debug("Failed to create new directory ");
			}
		}
		log.debug("createDirectory method returns boolean value : " + status);
		return status;

	}

	public static String hideEmailIdBySomeCharacters(String emailId, String hideCharacter, int start, int end)
			throws Exception {
		log.debug("hideEmailIdBySomeCharacters method called with parameter emailId :" + emailId
				+ " and hideCharacter :" + hideCharacter);

		StringBuilder emailIdStrBuilder = new StringBuilder(emailId);
		for (int i = start; i < emailIdStrBuilder.length() - end; i++) {
			if (emailIdStrBuilder.toString().charAt(i) == '@') {

			} else {
				emailIdStrBuilder.setCharAt(i, '*');
			}
		}
		log.debug("Get Hide email id : " + emailIdStrBuilder);
		return emailIdStrBuilder.toString();
	}

	public static String hideMobileNoBySomeCharacters(String mobileNo, String hideCharacter, int start, int end)
			throws Exception {
		log.debug("hideMobileNoBySomeCharacters method called with parameter mobileNo :" + mobileNo
				+ " and hideCharacter :" + hideCharacter);

		StringBuilder mobileNoStrBuilder = new StringBuilder(mobileNo);
		try {
			for (int i = start; i < mobileNoStrBuilder.length() - end; i++) {

				mobileNoStrBuilder.setCharAt(i, '*');
			}

			// mobileNo = mobileNoStrBuilder.toString();
			// if (!mobileNo.contains("+")) {
			// StringBuilder _sb = new StringBuilder(mobileNo);
			// mobileNo = _sb.insert(0, "+91").toString();
			// _sb = null;
			//
			// }
			log.debug("Get Hide mobile no : " + mobileNoStrBuilder);
			return mobileNoStrBuilder.toString();
		} finally {
			mobileNoStrBuilder = null;
		}

	}

	public static String hideStringBySomeCharacters(String str, String hideCharacter, int start, int end)
			throws Exception {
		// log.debug("hideStringBySomeCharacters method called with parameter String :"
		// + str + " and hideCharacter :"
		// + hideCharacter);

		StringBuilder strBuilder = new StringBuilder(str);
		for (int i = start; i < strBuilder.length() - end; i++) {

			strBuilder.setCharAt(i, '*');
		}
		log.debug("Get Hide mobile no : " + strBuilder);
		return strBuilder.toString();

	}

	// public static int getASCIIValueRem(String str) {
	// log.debug("getASCIIValueRem called");
	// log.debug("Requested string: " + str);
	//
	// // int sum_char = 0;
	// // // LOOP TO SUM THE ASCII VALUE OF CHARS
	// // for (int i = 0; i < str.length(); i++) {
	// // sum_char += (int) str.charAt(i);
	// // }
	// // // System.out.println("Sum chars: " + sum_char);
	// // return sum_char % 10;
	// return RemainderOfBigNumber.findRemainderOfBigNumber(str, 10);
	// }

	// REPOSITORY HELPER METHOD
	public static Map<String, String> getMapObjectFromJavaObjectNew(Class<?> modelObj) {
		log.debug("getMapObjectFromJavaObjectNew method called");
		Map<String, String> mapObj = null;

		try {
			mapObj = new HashMap<String, String>();

			Field[] allFields = modelObj.getDeclaredFields();

			for (Field field : allFields) {
				mapObj.put(field.getName(), field.get(modelObj).toString());
			}
		} catch (Exception e) {

		}
		log.debug("getMapObjectFromJavaObjectNew method returns map object:" + modelObj);

		return mapObj;

	}
	public static String getOSFromUserAgent(String userAgent) {
		log.debug("getOSFromUserAgent called");
		log.debug("UserAgent: " + userAgent);
		String os = "";
		try {
			// =================OS=======================
			if (userAgent.toLowerCase().indexOf("windows") >= 0) {
				os = "Windows";
			} else if (userAgent.toLowerCase().indexOf("mac") >= 0) {
				os = "Mac";
			} else if (userAgent.toLowerCase().indexOf("x11") >= 0) {
				os = "Unix";
			} else if (userAgent.toLowerCase().indexOf("android") >= 0) {
				os = "Android";
			} else if (userAgent.toLowerCase().indexOf("iphone") >= 0) {
				os = "IPhone";
			}
			return os;
		} catch (Exception e) {
			return "Windows";
		}
	}

	public static String getBrowserFromUserAgent(String userAgent) {
		log.debug("getBrowserFromUserAgent called");
		log.debug("UserAgent: " + userAgent);
		String browser = "";
		String user = userAgent.toLowerCase();

		try {
			// ===============Browser===========================
			if (user.contains("msie")) {
				// String substring =
				// userAgent.substring(userAgent.indexOf("MSIE")).split(";")[0];
				// browser = substring.split(" ")[0].replace("MSIE", "IE") + "-" +
				// substring.split(" ")[1];
				browser = "IE";
			} else if (user.contains("safari") && user.contains("version")) {
				// browser =
				// (userAgent.substring(userAgent.indexOf("Safari")).split("
				// ")[0]).split("/")[0] + "-"
				// + (userAgent.substring(userAgent.indexOf("Version")).split("
				// ")[0]).split("/")[1];
				browser = "Safari";
			} else if (user.contains("opr") || user.contains("opera")) {
				if (user.contains("opera"))
					browser = (userAgent.substring(userAgent.indexOf("Opera")).split(" ")[0]).split("/")[0] + "-"
							+ (userAgent.substring(userAgent.indexOf("Version")).split(" ")[0]).split("/")[1];
				else if (user.contains("opr"))
					// browser =
					// ((userAgent.substring(userAgent.indexOf("OPR")).split("
					// ")[0]).replace("/", "-"))
					// .replace("OPR", "Opera");
					browser = "Opera";
			} else if (user.contains("chrome")) {
				// browser =
				// (userAgent.substring(userAgent.indexOf("Chrome")).split("
				// ")[0]).replace("/", "-");
				browser = "Chrome";
			} else if ((user.indexOf("mozilla/7.0") > -1) || (user.indexOf("netscape6") != -1)
					|| (user.indexOf("mozilla/4.7") != -1) || (user.indexOf("mozilla/4.78") != -1)
					|| (user.indexOf("mozilla/4.08") != -1) || (user.indexOf("mozilla/3") != -1)) {
				// browser=(userAgent.substring(userAgent.indexOf("MSIE")).split("
				// ")[0]).replace("/", "-");
				// browser = "Netscape-?";
				browser = "Netscape";

			} else if (user.contains("firefox")) {
				// browser =
				// (userAgent.substring(userAgent.indexOf("Firefox")).split("
				// ")[0]).replace("/", "-");
				browser = "Firefox";
			} else if (user.contains("rv")) {
				// browser = "IE-" + user.substring(user.indexOf("rv") + 3,
				// user.indexOf(")"));
				browser = "IE";
			} else {
				browser = "UnKnown, More-Info: " + userAgent;
			}
			// log.info("Browser Name==========>" + browser);
			return browser;
		} catch (Exception e) {
			return "UnKnown";
		}
	}


	// RETURN END TIME FOR SESSION IN JUST 12 HRS
	public static Date convertDateStringInToDateObj(String dateStr) {
		log.debug("convertDateStringInToDateObj called");
		Date date = null;
		;
		try {
			date = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss").parse(dateStr);
		} catch (ParseException e) {
			log.debug("Escape Exception");
			e.printStackTrace();
		}
		return date;
	}
	// ADDED BY RAJEEV ON 21-10-2020
	// Thsi function to generate a random string of length n
	public static String getAlphaNumericStringOfSpecificLenth(int lenthOfString) {

		// chose a Character random from this String
		String AlphaNumericString = "ABCDEFGHIJKLMNOPQRSTUVWXYZ" + "0123456789" + "abcdefghijklmnopqrstuvxyz";

		// create StringBuffer size of AlphaNumericString
		StringBuilder sb = new StringBuilder(lenthOfString);

		for (int i = 0; i < lenthOfString; i++) {

			// generate a random number between
			// 0 to AlphaNumericString variable length
			int index = (int) (AlphaNumericString.length() * Math.random());

			// add Character one by one in end of sb
			sb.append(AlphaNumericString.charAt(index));
		}

		return sb.toString();
	}

	public static String getAlphaNumericString(int lenthOfString) {

		// chose a Character random from this String
		String AlphaNumericString = "0123456789" + "abcdefghijklmnopqrstuvxyz";

		// create StringBuffer size of AlphaNumericString
		StringBuilder sb = new StringBuilder(lenthOfString);

		for (int i = 0; i < lenthOfString; i++) {

			// generate a random number between
			// 0 to AlphaNumericString variable length
			int index = (int) (AlphaNumericString.length() * Math.random());

			// add Character one by one in end of sb
			sb.append(AlphaNumericString.charAt(index));
		}

		return sb.toString();
	}

	public static void generateCaptchaStyle1(HttpServletRequest request, HttpServletResponse response,
			String captchaStr) {

		log.debug("generateCaptchaStyle1 called with parameter capcha string :" + captchaStr);

		ResourceBundle rbAPP = ResourceBundle.getBundle("app");

		int width, height;

		try {
			// MAKE ITS BUFFER IMAGE
			width = Integer.parseInt(rbAPP.getString("CAPTCHA_WIDTH"));
			height = Integer.parseInt(rbAPP.getString("CAPTCHA_HEIGHT"));

			BufferedImage bufferedImage = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
			Graphics2D g2d = bufferedImage.createGraphics();
			Font font = new Font("Consolas", Font.BOLD, 22);
			g2d.setFont(font);

			RenderingHints rh = new RenderingHints(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);
			rh.put(RenderingHints.KEY_RENDERING, RenderingHints.VALUE_RENDER_DEFAULT);
			g2d.setRenderingHints(rh);

			// GradientPaint gp = new GradientPaint(0, 0, Color.red, 0, height / 2,
			// Color.black, true);
			GradientPaint gp = new GradientPaint(0, 0, Color.CYAN, 0, height / 2, Color.blue, true);
			g2d.setPaint(gp);
			g2d.fillRect(0, 0, width, height);
			g2d.setColor(new Color(255, 153, 0));
			captchaStr = captchaStr.replaceAll("\\.", "$0 ");
			log.debug("To add space character in enerated captcha string and found modified captcha String "
					+ captchaStr);
			g2d.drawString(captchaStr, 10, 35);
			g2d.dispose();
			response.setContentType("image/png");

			OutputStream os = response.getOutputStream();
			ImageIO.write(bufferedImage, "png", os);
			os.flush();
			os.close();

		} catch (Exception e) {
			log.debug("Escape Exception");
		} finally {

		}
	}

	public static void generateCaptchaStyle2(HttpServletRequest request, HttpServletResponse response,
			String captchaStr) {

		log.debug("generateCaptchaStyle2 called with parameter capcha string :" + captchaStr);

		int width, height;
		BufferedImage bufferedImage = null;

		try {
			Color backgroundColor = Color.white;
			Color borderColor = Color.black;
			Color textColor = Color.black;
			Color circleColor = new Color(190, 160, 150);
			Font textFont = new Font("Consolas", Font.BOLD, 35);
			int charsToPrint = 6;
			width = 160;
			height = 50;
			int circlesToDraw = 25;
			float horizMargin = 10.0f;
			double rotationRange = 0.7;
			bufferedImage = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
			Graphics2D g = (Graphics2D) bufferedImage.getGraphics();
			g.setColor(backgroundColor);
			g.fillRect(0, 0, width, height);

			// lets make some noisey circles
			g.setColor(circleColor);
			for (int i = 0; i < circlesToDraw; i++) {
				int L = (int) (Math.random() * height / 2.0);
				int X = (int) (Math.random() * width - L);
				int Y = (int) (Math.random() * height - L);
				g.draw3DRect(X, Y, L * 2, L * 2, true);
			}
			g.setColor(textColor);
			g.setFont(textFont);
			FontMetrics fontMetrics = g.getFontMetrics();
			int maxAdvance = fontMetrics.getMaxAdvance();
			int fontHeight = fontMetrics.getHeight();

			char[] chars = captchaStr.toCharArray();
			float spaceForLetters = -horizMargin * 2 + width;
			float spacePerChar = spaceForLetters / (charsToPrint - 1.0f);
			StringBuffer finalString = new StringBuffer();
			for (int i = 0; i < charsToPrint; i++) {

				char characterToShow = chars[i];
				finalString.append(characterToShow);

				// this is a separate canvas used for the character so that
				// we can rotate it independently
				int charWidth = fontMetrics.charWidth(characterToShow);
				int charDim = Math.max(maxAdvance, fontHeight);
				int halfCharDim = (int) (charDim / 2);
				BufferedImage charImage = new BufferedImage(charDim, charDim, BufferedImage.TYPE_INT_ARGB);
				Graphics2D charGraphics = charImage.createGraphics();
				charGraphics.translate(halfCharDim, halfCharDim);
				double angle = (Math.random() - 0.5) * rotationRange;
				charGraphics.transform(AffineTransform.getRotateInstance(angle));
				charGraphics.translate(-halfCharDim, -halfCharDim);
				charGraphics.setColor(textColor);
				charGraphics.setFont(textFont);
				int charX = (int) (0.5 * charDim - 0.5 * charWidth);
				charGraphics.drawString("" + characterToShow, charX,
						(int) ((charDim - fontMetrics.getAscent()) / 2 + fontMetrics.getAscent()));

				float x = horizMargin + spacePerChar * (i) - charDim / 2.0f;
				int y = (int) ((height - charDim) / 2);
				g.drawImage(charImage, (int) x, y, charDim, charDim, null, null);
				charGraphics.dispose();
			}
			g.setColor(borderColor);
			g.drawRect(0, 0, width - 1, height - 1);
			g.dispose();

			response.setContentType("image/png");

			OutputStream os = response.getOutputStream();
			ImageIO.write(bufferedImage, "png", os);
			os.flush();
			os.close();

			// return bufferedImage;
		} catch (Exception ioe) {
			throw new RuntimeException("Unable to build image, please try after some times.", ioe);
		}
	}

	// ADD BY RAJEEV ON 18-11-2020
	public static boolean checkServiceAuthrizationBasedDeptForParichayApplication(
			String getDeptAllowValueFromServiceDetails, String getDeptValueFromUserBasicDetails) throws Exception {
		log.debug("checkServiceAuthrizationBasedDeptForParichayApplication service helper method called");
		boolean serviceAuthrizationStatus = false;

		if (getDeptAllowValueFromServiceDetails.equals("ALL")) {
			log.debug("User is applicable for access the service");
			serviceAuthrizationStatus = true;
			log.debug("checkServiceAuthrizationForParichayApplication service helper method returns boolean value :"
					+ serviceAuthrizationStatus);
			return serviceAuthrizationStatus;
		}
		if (getDeptAllowValueFromServiceDetails.equals(getDeptValueFromUserBasicDetails)) {
			log.debug("User is applicable for access the service");
			serviceAuthrizationStatus = true;
		} else {
			log.debug("User is not applicable for access the service");
			serviceAuthrizationStatus = false;
		}
		log.debug(
				"checkServiceAuthrizationBasedDeptForParichayApplication service helper method returns boolean value :"
						+ serviceAuthrizationStatus);
		return serviceAuthrizationStatus;
	}
	public static String getClientIp(HttpServletRequest request) {
		log.debug("getClientIp method called");
		String remoteAddr = "";

		if (request != null) {
			remoteAddr = request.getHeader("X-FORWARDED-FOR");
			log.debug("remoteAddr : " + remoteAddr);
			if (remoteAddr == null || "".equals(remoteAddr)) {
				remoteAddr = request.getRemoteAddr();
			}
		}

		log.debug("getClientIp method returns remote client ip:" + remoteAddr);
		return remoteAddr;
	}
	// Generic function to convert set to list
	public static List<String> convertSetToList(Set<String> set) {
		// create an empty list
		List<String> list = new ArrayList<>();

		// push each element in the set into the list
		for (String s : set)
			list.add(s);

		// return the list
		log.debug("convertSetToList method returns list :" + list);
		return list;
	}


	public static boolean isFileExists(String fileName) {
		log.debug("isFileExists called: " + fileName);

		ResourceBundle rbForConfig = ResourceBundle.getBundle("config");

		File f = null;
		try {
			log.debug("Path: " + rbForConfig.getString("IMAGE_PATH") + fileName + ".png");
			// Get the file
			f = new File(rbForConfig.getString("IMAGE_PATH") + fileName + ".png");

			// Check if the specified file
			// Exists or not
			if (f.exists()) {
				log.debug("Exists");
				return true;
			} else {
				log.debug("Does not Exists");
				return false;
			}

		} catch (Exception e) {
			return false;
		} finally {
			f = null;
		}
	}

	public static List<String> generateListOfSixDigitRandomNos(int sizeList) {
		log.debug("generateListOfSixDigitRandomNos() method called with sizeList:" + sizeList);
		List<String> backupCodesList = null;
		try {
			backupCodesList = new ArrayList<String>();
			for (int i = 0; i < sizeList; i++) {
				backupCodesList.add(i, genrateRandomNumber(6));
			}
		} catch (Exception e) {
			log.debug("Escape Exception");
		}

		log.debug("generateListOfSixDigitRandomNos() method returns List of backup codes : " + backupCodesList);

		return backupCodesList;
	}

	private static SecureRandom secureRandom = new SecureRandom();

	public static String genrateRandomNumber(final int lengthOfOTP) {

		StringBuilder generatedOTP = new StringBuilder();

		try {

			secureRandom = SecureRandom.getInstance(secureRandom.getAlgorithm());

			for (int i = 0; i < lengthOfOTP; i++) {
				generatedOTP.append(secureRandom.nextInt(9));
			}
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}

		return generatedOTP.toString();
	}

	// ADDED BY RAJEEV ON 23-09-2021
	public static String getCapitalizedOfFirstCharInString(String str) {
		log.debug("getCapitalizedOfFirstCharInString method called with parameter string : " + str);
		try {
			log.debug("try");
			if (!str.isEmpty() && str != null) {
				log.debug("if");
				str = str.toLowerCase();
				log.debug("get string as lower case : " + str);
				str = str.substring(0, 1).toUpperCase() + str.substring(1);
				log.debug("getCapitalizedOfFirstCharInString method returns capitalized string : " + str);
				return str;
			}
		} catch (Exception e) {
			log.debug("Escape Exception");
		}
		return null;
	}

	// ADDED BY RAJEEV ON 23-09-2021
	public static String getCapitalizedOfFirstCharInStringArray(String strArray[]) {
		log.debug("getCapitalizedOfFirstCharInString method called with parameter strArray : " + strArray);
		try {
			log.debug("try");
			if (strArray != null) {
				log.debug("if");
				String capitalizedStr = "";
				for (String str : strArray) {
					capitalizedStr = capitalizedStr + " " + getCapitalizedOfFirstCharInString(str);

				}

				log.debug("getCapitalizedOfFirstCharInString method returns capitalized string : " + capitalizedStr);
				return capitalizedStr;
			}
		} catch (Exception e) {
			log.debug("Escape Exception");
		}
		return null;
	}

	public static String generateSixDigitRandomNo() {
		log.debug("generateSixDigitRandomNo() method called");
		SecureRandom rand = new SecureRandom();
		int generatecode = 100000 + rand.nextInt(900000);
		log.debug("Code has generated : " + generatecode);
		String generatedCode = String.valueOf(generatecode);
		log.debug("generateSixDigitRandomNo() method returns generate code as string : " + generatedCode);

		return generatedCode;
	}

	// public Utility() {
	// System.out.println("Hello");
	// }
	// public static void main(String[] args) {
	// String date = Utility.getCurrentDateTime();
	// System.out.println(date);
	//
	//// Calendar now = Calendar.getInstance();
	//// now.add(Calendar.MINUTE, 30);
	//
	// // Date isoDate = (Date) doc.get("createdAt");
	// Date isoDate = new Date();
	// System.out.println("Before: "+isoDate);
	// Calendar now = Calendar.getInstance();
	// now.setTime(isoDate);
	// now.add(Calendar.HOUR, 12);
	// System.out.println("After: "+now.getTime());
	//
	// }
	public static int generateRandomDigits(int n) {
		int m = (int) Math.pow(10, n - 1);
		return m + new Random().nextInt(9 * m);
	}

	// CREATE RESEND OTP COUNT KEY
	public static String getRegistrationResendOTPCountKey(String registrationReqStatus) {
		return "resendotpcount@" + registrationReqStatus;
	}

	// added by rajeev on 09-02-2021
	public static String getRegistrationOTPKey(String key, String registrationReqStatus) {
		return "otp@" + key + "@" + registrationReqStatus;
	}

	// CREATE OTP COUNT KEY
	public static String getRegistrationOTPCountKey(String key, String registrationReqStatus) {
		return "otpcount@" + key + "@" + registrationReqStatus;
	}

	// ADDED BY RAJEEV ON 15-11-2021
	public static String getResendOTPCountKey(String key) {
		return "resendotpcount@" + key;
	}

	public static String generateTenDigitRandomNo() {
		log.debug("generateTenDigitRandomNo() method called");
		SecureRandom rand = new SecureRandom();
		long generatecode = 1000000000 + rand.nextLong();
		log.debug("Code has generated : " + generatecode);
		String generatedCode = String.valueOf(generatecode);
		log.debug("generateSixDigitRandomNo() method returns generate code as string : " + generatedCode);

		return generatedCode;
	}


	public static byte[] getSHA(String input) throws NoSuchAlgorithmException {
		// Static getInstance method is called with hashing SHA
		MessageDigest md = MessageDigest.getInstance("SHA-256");

		// digest() method called
		// to calculate message digest of an input
		// and return array of byte
		return md.digest(input.getBytes(StandardCharsets.UTF_8));
	}

	public static String toHexString(byte[] hash) {
		// Convert byte array into signum representation
		BigInteger number = new BigInteger(1, hash);

		// Convert message digest into hex value
		StringBuilder hexString = new StringBuilder(number.toString(16));

		// Pad with leading zeros
		while (hexString.length() < 32) {
			hexString.insert(0, '0');
		}

		return hexString.toString();
	}

	// ADDED BY RAJEEV ON 29-10-2021

	public static String getEncryptedString(String plainText, String aesKey)
			throws NoSuchPaddingException, NoSuchAlgorithmException, InvalidAlgorithmParameterException,
			InvalidKeyException, BadPaddingException, IllegalBlockSizeException {
		log.debug(
				"getEncryptedString method called with parameter plainText : " + plainText + " and aesKey : " + aesKey);

		ResourceBundle rbForEncryption = ResourceBundle.getBundle("encryption");
		String encrypAlgo = null;
		String initVector = null;
		try {
			encrypAlgo = rbForEncryption.getString("AES_ALGORITHM");
			initVector = rbForEncryption.getString("AES_INITVECTOR");

			IvParameterSpec iv = new IvParameterSpec(initVector.getBytes("UTF-8"));
			SecretKeySpec skeySpec = new SecretKeySpec(aesKey.getBytes("UTF-8"), "AES");

			Cipher cipher = Cipher.getInstance(encrypAlgo);
			cipher.init(Cipher.ENCRYPT_MODE, skeySpec, iv);

			byte[] encrypted = cipher.doFinal(plainText.getBytes());

			log.debug("getEncryptedString method called returns encrypted string : "
					+ Base64.encodeBase64String(encrypted));
			return Base64.encodeBase64String(encrypted);
		} catch (Exception e) {
			log.debug("getEncryptedString method called returns encrypted string  as null ");
			return null;
		}

	}

	/*
	 * public static String getDecryptedString(String encryptedStr, String
	 * secretKey, String ivKey) {
	 * log.debug("getDecryptedString method called with parameter encryptedStr : " +
	 * encryptedStr + " , secretKey : " + secretKey + " and ivKey : " + ivKey);
	 * ResourceBundle rbForEncryption = ResourceBundle.getBundle("encryption");
	 * 
	 * String original = null;
	 * 
	 * try {
	 * 
	 * log.debug("Base64 encryptedStr : "+Base64.decodeBase64(encryptedStr));
	 * log.debug("Base64 secretKey : "+Base64.decodeBase64(secretKey));
	 * log.debug("Base64 ivKey : "+Base64.decodeBase64(ivKey));
	 * 
	 * byte[] encryptedByteData = AES.hexStringToByteArray(encryptedStr);
	 * 
	 * IvParameterSpec ivs = new IvParameterSpec(Base64.decodeBase64(ivKey)); Key
	 * key = new SecretKeySpec(Base64.decodeBase64(secretKey),"AES");
	 * 
	 * // original = AES.decrypt(Base64.encodeBase64String(encryptedByteData), k,
	 * ivs); // System.out.println("original Text : " + original); Cipher cipher =
	 * Cipher.getInstance(rbForEncryption.getString("AES_ALGORITHM"));
	 * cipher.init(Cipher.DECRYPT_MODE, key, ivs);
	 * 
	 * byte[] stringBytes = cipher.doFinal(Base64.decodeBase64(encryptedByteData));
	 * original = stringBytes.toString();
	 * 
	 * log.debug("getDecryptedString method called returns decrypted string : " +
	 * original.toString()); return original.toString();
	 * 
	 * } catch (Exception ex) { ex.printStackTrace(); return null; } finally {
	 * original = null; // encrypAlgo = null; }
	 * 
	 * }
	 */
	// RETURN SHA256 FORM OF A STRING
	public static String getSha256(String txt) throws NoSuchAlgorithmException {
		return toHexString(getSHA(txt));
	}

	public static String getSha512(String input) throws NoSuchAlgorithmException {

		MessageDigest md = MessageDigest.getInstance("SHA-512");

		return toHexString(md.digest(input.getBytes(StandardCharsets.UTF_8)));
	}

	public static String getOTPLockoutKey(String preSID) {
		return "otpLock@" + preSID;
	}
	// public static String pushDetailsToOdisha(String firstName, String lastName,
	// String gender, String mobileNo,
	// String emailId, String userId, String signal) {
	// log.debug("pushDetailsToOdisha called");
	// log.debug("FirstName: " + firstName);
	// log.debug("LastName: " + lastName);
	// log.debug("Gender: " + gender);
	// log.debug("MobileNo: " + mobileNo);
	// log.debug("EmailId: " + emailId);
	// log.debug("UserId: " + userId);
	// log.debug("Signal: " + signal);
	//
	// String restAPIURL = null;
	// String restApiRespAsJsonStr = "failure";
	// String postParams = null;
	// HttpClient httpClient = null;
	// StringEntity entity = null;
	// JSONObject apiResponseJSON = null;
	// HttpResponse clientResponse = null;
	// String apiResponse = null;
	// JSONParser parser = null;
	// HttpPost httpPost = null;
	//
	// try {
	//
	// restAPIURL = "http://52.172.129.49/odisha-one-sso/api/v1/sso/user/register";
	// httpPost = new HttpPost(restAPIURL);
	//
	// // postParams = "{\"userId\":\"" + userName + "\",\"passwd\":\"" +
	// // SPPasswordAlgo.getSPEncryptedPwd(signal)
	// // + "\"}";
	// postParams = "{\"firstName\":\"" + firstName + "\",\"lastName\":\"" +
	// lastName + "\",\"mobile\":\""
	// + mobileNo + "\",\"lastName\":\"" + lastName + "\",\"email\":\"" + emailId +
	// "\",\"password\":\""
	// + AesUtil.getEncryptedString(signal) + "\",\"username\":\"" + userId
	//
	// + "\"}";
	// log.debug("Post Params: " + postParams);
	//
	// entity = new StringEntity(postParams);
	//
	// // SET REQUEST HEADERS
	// httpPost.setHeader("Content-Type", "application/json");
	//
	// // SET REQUEST HEADERS
	// try {
	// httpClient = new DefaultHttpClient();
	// // DefaultHttpClient httpClient1 = new DefaultHttpClient();
	// // httpClient = HttpSecureCon.wrapClient(httpClient1);
	// clientResponse = httpClient.execute(httpPost);
	// try {
	// apiResponse = EntityUtils.toString(clientResponse.getEntity());
	// log.debug("API response: " + apiResponse);
	//
	// if (apiResponse.contains("404 page not found")) {
	// return "na";
	// } else {
	//
	// // CONVERT RESPONSE STRING TO JSON OBJECT
	// parser = new JSONParser();
	// apiResponseJSON = (JSONObject) parser.getJSONObject(apiResponse);
	// }
	//
	// } catch (Exception e) {
	// e.printStackTrace();
	// log.debug("Timeout occurs");
	// return "na";
	//
	// }
	// } catch (Exception e) {
	// log.error("Error occured while calling API: " +
	// e.getClass().getCanonicalName());
	// e.printStackTrace();
	// // return "na";
	// return "success";
	//
	// } finally {
	// // CLOSE THE RESOURCES
	// httpPost = null;
	// entity = null;
	// httpClient = null;
	// clientResponse = null;
	// parser = null;
	//
	// }
	//
	// try {
	// log.debug("Odisha API Response: " + apiResponseJSON.get("message"));
	//
	// if ("You have been successfully registered"
	// .equalsIgnoreCase(apiResponseJSON.get("message").toString())) {
	// restApiRespAsJsonStr = "success";
	// }
	// restApiRespAsJsonStr = "success";
	// } catch (Exception e) {
	// // restApiRespAsJsonStr = "success";
	// }
	//
	// httpClient = null;
	// log.debug("http client connection has closed ");
	// return restApiRespAsJsonStr;
	//
	// } catch (Exception e) {
	// log.error("Error occurred while calling Service API");
	// e.printStackTrace();
	// // return "na";
	// return "success";
	//
	// } finally {
	// restAPIURL = null;
	// restApiRespAsJsonStr = null;
	// postParams = null;
	// apiResponseJSON = null;
	// apiResponse = null;
	//
	// }
	//
	// }
	private static volatile SecureRandom numberGenerator = null;
	private static final long MSB = 0x8000000000000000L;

	public static String unique() {
		SecureRandom ng = numberGenerator;
		if (ng == null) {
			numberGenerator = ng = new SecureRandom();
		}

		return Long.toHexString(MSB | ng.nextLong()) + Long.toHexString(MSB | ng.nextLong());
	}

	public static void main(String[] args) {
		// try {
		// String email = "email@gmail.com";
		// String firstName = "First";
		// String gender = "Male";
		// String lastName = "Last";
		// String mobile = "5556824245";
		// String password = "Test@123";
		// String username = "Test_User";
		//
		// String amqpMessage =
		// "http://52.172.129.49/odisha-one-sso/api/v1/sso/user/register" + "@#@#@#@#@#"
		// + "{\"email\":\"" + email + "\",\"firstName\":\"" + firstName +
		// "\",\"gender\":\"" + gender
		// + "\",\"lastName\":\"" + lastName + "\",\"mobile\":\"" + mobile +
		// "\",\"password\":\"" + password
		// + "\",\"username\":\"" + username + "\"}";
		// System.out.println(amqpMessage);
		// } catch (Exception e) {
		//
		// }
		// System.out.println(unique());
		System.out.println(UUID.randomUUID().toString());
		System.out.println(unique());

	}

}
