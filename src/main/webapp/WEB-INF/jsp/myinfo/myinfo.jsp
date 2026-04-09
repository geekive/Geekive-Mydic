<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/jstlcore.jsp"%>

<c:set var="pageContent">
<style>
/* My Info page helpers */
.field-msg{
  margin-top: 8px;
  font-size: 12px;
  line-height: 1.35;
  padding: 8px 10px;
  border-radius: 12px;
  border: 1px solid var(--line);
  background: rgba(255,255,255,.02);
  color: var(--muted);
}
.field-msg.ok{
  border-color: rgba(96,165,250,.30);
  background: rgba(96,165,250,.08);
  color: rgba(255,255,255,.86);
}
.field-msg.err{
  border-color: rgba(239,68,68,.28);
  background: rgba(239,68,68,.10);
  color: rgba(255,255,255,.88);
}
/* =========================
   My Info – Centered Layout
========================= */

.myinfo-center{
  min-height: calc(100vh - (var(--header-h) + 18px + 14px + 40px));
  display: grid;
  place-items: center;
  padding: 18px 0 10px;
}

.myinfo-card{
  width: min(520px, 100%);
}
</style>
	<main class="myinfo-center">
		<section class="card myinfo-card" aria-label="My Info">

			<div class="card-h">
				<strong>My Info</strong>
				<div class="actions" style="gap: 8px;">
					<button class="btn" id="btn-mi-edit" type="button">Edit</button>
					<button class="btn" id="btn-mi-cancel" type="button"
						style="display: none;">Cancel</button>
					<button class="btn primary" id="btn-mi-save" type="button" disabled
						style="display: none;">Save</button>
				</div>
			</div>

			<div class="card-b">
				<div class="hint" style="margin-bottom: 12px;">Email is
					locked. You can update your name and password.</div>

				<form class="form" id="myInfoForm" autocomplete="off">

					<label> E-mail (locked) <input id="mi-email" type="text"
						disabled placeholder="example@domain.com" value="${sessionScope.userMap.email}">
					</label> <label> Name <input id="mi-name" type="text" disabled
						placeholder="name" maxlength="30"
						oninput="this.value=this.value.trim();" value="${sessionScope.userMap.name}">
					</label> <label> New Password <input id="mi-password"
						type="password" disabled placeholder="********"
						oninput="this.value=this.value.trim();">
						<div class="hint">Leave blank if you don't want to change
							it. (min 8 chars)</div>
					</label> <label> Password Check <input id="mi-password-check"
						type="password" disabled placeholder="********"
						oninput="this.value=this.value.trim();">
						<div class="field-msg" id="pwMsg" style="display: none;"></div>
					</label>

					<div class="actions" style="justify-content: space-between;">
						<div class="hint" id="saveHint">Click “Edit” to modify your
							info.</div>
					</div>

				</form>
			</div>
		</section>
	</main>

<script>
$(function () {

  /* =========================
     Element refs
  ========================= */
  const $email   = $('#mi-email');
  const $name    = $('#mi-name');
  const $pw      = $('#mi-password');
  const $pwCheck = $('#mi-password-check');
  const $pwMsg   = $('#pwMsg');

  const $btnEdit   = $('#btn-mi-edit');
  const $btnCancel = $('#btn-mi-cancel');
  const $btnSave   = $('#btn-mi-save');
  const $saveHint  = $('#saveHint');

  let original = {
    email: '',
    name : ''
  };

  /* =========================
     Init: load my info
     (API 경로는 필요에 맞게 수정)
  ========================= */
  $.ajax({
    type        : 'post',
    url         : getFullPath('/my/info/get'),
    contentType : 'application/json',
    data        : JSON.stringify({}),
    success     : function (res) {
      if (res && res.resultCode === 1) {
        original.email = res.email || '';
        original.name  = res.name  || '';

        $email.val(original.email);
        $name.val(original.name);

        // header pill name sync (있으면)
        if ($('#pillText').length) {
          $('#pillText').text(original.name || 'User');
        }
      } else {
        alert(res?.resultMessage || 'Failed to load user info.');
      }
    }
  });

  /* =========================
     Edit mode toggle
  ========================= */
  function setEditMode(on) {
    $name.prop('disabled', !on);
    $pw.prop('disabled', !on);
    $pwCheck.prop('disabled', !on);

    $btnEdit.toggle(!on);
    $btnCancel.toggle(on);
    $btnSave.toggle(on);

    if (on) {
      $btnSave.prop('disabled', true);
      $saveHint.text('Update your name and password, then Save.');
      setTimeout(() => $name.trigger('focus'), 0);
    } else {
      $saveHint.text('Click “Edit” to modify your info.');
      clearPasswordState();
      $pw.val('');
      $pwCheck.val('');
    }
  }

  /* =========================
     Password validation UI
  ========================= */
  function clearPasswordState() {
    $pwMsg.hide().removeClass('ok err').text('');
  }

  function showPasswordMsg(type, text) {
    $pwMsg
      .show()
      .removeClass('ok err')
      .addClass(type)
      .text(text);
  }

  /* =========================
     Validation rules
     - name >= 3 chars
     - password optional
     - password >= 8 chars
     - password match
  ========================= */
  function validateForm() {
    const name = $.trim($name.val());
    const pw   = $.trim($pw.val());
    const chk  = $.trim($pwCheck.val());

    if (name.length < 3) {
      showPasswordMsg('err', 'Name must be at least 3 characters long.');
      return false;
    }

    // password not changing
    if (!pw && !chk) {
      clearPasswordState();
      return true;
    }

    if (pw.length < 8) {
      showPasswordMsg('err', 'Password must be at least 8 characters long.');
      return false;
    }

    if (pw !== chk) {
      showPasswordMsg('err', 'Password confirmation does not match.');
      return false;
    }

    showPasswordMsg('ok', 'Password looks good.');
    return true;
  }

  function syncSaveState() {
    const ok = validateForm();
    $btnSave.prop('disabled', !ok);
  }

  /* =========================
     Events
  ========================= */
  $btnEdit.on('click', () => setEditMode(true));

  $btnCancel.on('click', () => {
    $name.val(original.name);
    setEditMode(false);
  });

  $name.on('input', syncSaveState);
  $pw.on('input', syncSaveState);
  $pwCheck.on('input', syncSaveState);

  /* =========================
     Save
  ========================= */
  function saveMyInfo() {
    if (!validateForm()) return;

    const payload = {
      name     : $.trim($name.val()),
      password : $.trim($pw.val()) || ''   // 빈 값 = 변경 안 함
    };

    $.ajax({
      type        : 'post',
      url         : getFullPath('/my/info/save'),
      contentType : 'application/json',
      data        : JSON.stringify(payload),
      beforeSend  : function () {
        $btnSave.prop('disabled', true);
      },
      success     : function (res) {
        if (res && res.resultCode === 1) {
          original.name = payload.name;

          if ($('#pillText').length) {
            $('#pillText').text(original.name || 'User');
          }

          alert(res.resultMessage || 'Saved.');
          setEditMode(false);
        } else {
          alert(res?.resultMessage || 'Save failed.');
          syncSaveState();
        }
      }
    });
  }

  $btnSave.on('click', saveMyInfo);

  $('#myInfoForm').on('submit', function (e) {
    e.preventDefault();
    saveMyInfo();
  });

  /* =========================
     Initial state
  ========================= */
  setEditMode(false);

});
</script>
</c:set>

<%@ include file="/WEB-INF/jsp/common/layout.jsp"%>
