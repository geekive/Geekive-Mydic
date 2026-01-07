<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/jstlcore.jsp"%>

<div style="margin:0; padding:0; background:#0b0f19; width:100%;">
  <table role="presentation" cellpadding="0" cellspacing="0" border="0" width="100%"
         style="border-collapse:collapse; background:#0b0f19; width:100%;">
    <tr>
      <td align="center" style="padding:28px 16px;">
        <table role="presentation" cellpadding="0" cellspacing="0" border="0" width="600"
               style="width:600px; max-width:600px; border-collapse:separate;">
          <tr>
            <td style="
              padding:14px 14px;
              border:1px solid rgba(255,255,255,.08);
              border-radius:16px;
              background: rgba(17,24,39,.70);
              box-shadow: 0 10px 26px rgba(0,0,0,.25);
            ">
              <table role="presentation" width="100%" cellpadding="0" cellspacing="0" border="0">
                <tr>
                  <td align="left" style="vertical-align:middle;">
                    <div style="font-family: ui-sans-serif, system-ui, -apple-system, Segoe UI, Roboto, 'Noto Sans KR', Arial, sans-serif;">
                      <div style="font-size:15px; color:rgba(255,255,255,.92); font-weight:700; letter-spacing:.2px; margin-top:2px;">
                        <spring:message code="email.common.greeting"/>
                      </div>
                    </div>
                  </td>
                  <td align="right" style="vertical-align:middle;">
                    <span style="
                      display:inline-block;
                      width:10px; height:10px;
                      border-radius:999px;
                      background: linear-gradient(135deg, #60a5fa, #a78bfa);
                      box-shadow: 0 0 0 4px rgba(96,165,250,.12);
                    "></span>
                  </td>
                </tr>
              </table>
            </td>
          </tr>

          <tr>
            <td style="padding:14px 0 0;">
              <table role="presentation" cellpadding="0" cellspacing="0" border="0" width="100%"
                     style="
                       border-collapse:separate;
                       border:1px solid rgba(255,255,255,.08);
                       border-radius:22px;
                       background: linear-gradient(180deg, rgba(255,255,255,.045), rgba(255,255,255,.02));
                       box-shadow: 0 18px 50px rgba(0,0,0,.35);
                       overflow:hidden;
                     ">
                <tr>
                  <td style="padding:26px 18px 18px;">
                    <div style="
                      font-family: ui-sans-serif, system-ui, -apple-system, Segoe UI, Roboto, 'Noto Sans KR', Arial, sans-serif;
                      text-align:center;
                      color:rgba(255,255,255,.92);
                    ">
                      <div style="font-size:14px; line-height:1.65; color:rgba(255,255,255,.78); max-width:520px; margin:0 auto;">
                        {{message}}
                      </div>

                      <div style="height:1px; background:rgba(255,255,255,.08); margin:16px auto 14px; width:80%;"></div>

                      <div style="
                        display:inline-block;
                        padding:14px 16px;
                        border-radius:18px;
                        border:1px solid rgba(255,255,255,.08);
                        background: rgba(255,255,255,.02);
                        box-shadow: 0 10px 26px rgba(0,0,0,.25);
                        text-align:center;
                        min-width:240px;
                      ">
                        <div style="font-size:12px; color:rgba(255,255,255,.64); letter-spacing:.2px; margin-bottom:8px;">
                          Verification Code
                        </div>
                        <div style="
                          font-family: ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, 'Liberation Mono', 'Courier New', monospace;
                          font-size:28px;
                          font-weight:800;
                          letter-spacing:2px;
                          line-height:1.1;
                          background: linear-gradient(135deg, rgba(255,255,255,.96), rgba(96,165,250,.95), rgba(167,139,250,.92));
                          -webkit-background-clip:text;
                          background-clip:text;
                          color:transparent;
                          user-select:text;
                        ">
                          {{code}}
                        </div>
                      </div>

                      <div style="margin-top:16px; font-size:12px; color:rgba(255,255,255,.64); line-height:1.6;">
                        <spring:message code="email.common.ignore"/>
                      </div>
                    </div>
                  </td>
                </tr>

                <tr>
                  <td style="
                    padding:16px 18px 20px;
                    border-top:1px solid rgba(255,255,255,.08);
                    text-align:center;
                    font-family: ui-sans-serif, system-ui, -apple-system, Segoe UI, Roboto, 'Noto Sans KR', Arial, sans-serif;
                  ">
                    <div style="font-size:12px; color:rgba(255,255,255,.64); line-height:1.65;">
                      <spring:message code="email.common.regards"/><br/>
                      <span style="color:rgba(255,255,255,.78); font-weight:600;">
                        <spring:message code="email.common.signature"/>
                      </span>
                    </div>
                  </td>
                </tr>
              </table>
            </td>
          </tr>

          <tr>
            <td style="padding:14px 0 0; text-align:center;">
              <div style="
                font-family: ui-sans-serif, system-ui, -apple-system, Segoe UI, Roboto, 'Noto Sans KR', Arial, sans-serif;
                font-size:11px;
                color:rgba(255,255,255,.45);
                line-height:1.6;
              ">
                © Mydic
              </div>
            </td>
          </tr>

        </table>
      </td>
    </tr>
  </table>
</div>
