// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html";
import $ from "jquery";

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"

function start_click(ev) {
  console.log("start click");
  let btn = $(ev.target);
  let task_id = btn.data('task-id');
  let start_time = btn.data('start-time');
  if (start_time == "") {
    $(btn).text("Stop");
    $(btn).removeClass('btn-success').addClass('btn-danger');
    $(btn).data("start-time", new Date);
  } else {
    let end_time = new Date();
    let data = JSON.stringify({time_block:{
      start: start_time,
      end: end_time,
      task_id: task_id
    }});

    $.ajax(
      tb_path, {
        method: "post",
        dataType: "json",
        contentType: "application/json; charset=UTF-8",
        data: data,
        success: resp => {
          $(btn).text("Start");
          $(btn).removeClass('btn-danger').addClass('btn-success');
          $(btn).data('start-time', '');
        }
      });
  }
}

function del_tb(ev) {
  let btn = $(ev.target);
  let tb_id = btn.data('tb-id');

  $.ajax(
    tb_path + "/" + tb_id,
    {
      method: "delete",
      dataType: "json",
      contentType: "application/json; charset=UTF-8",
      data: "",
      success: () => {alert("delete succeed"); location.reload()},
    });
}

function update_tb(ev) {
  let btn = $(ev.target);
  let tb_id = btn.data('tb-id');
  let task_id = btn.data('task-id')
  let start_time = new Date($('#tb-s-'+tb_id).val())
  let end_time = new Date($('#tb-e-'+tb_id).val())

  if (start_time < end_time) {
    let data = JSON.stringify({
      time_block: {
        id: tb_id,
        start: start_time,
        end: end_time,
        task_id: task_id
      }
    });

    $.ajax(tb_path + "/" + tb_id, {
      method: "put",
      dataType: "json",
      contentType: "application/json; charset=UTF-8",
      data: data,
      success: () => alert("update succeed")
    });


  } else {
    alert("input error");
  }
}

function init() {
  let del_btns = $('.del-btn');
  if (del_btns) del_btns.click(del_tb);

  let start_btns = $('.start-btn');
  if (start_btns) start_btns.click(start_click);

  let update_btns = $('.update-btn');
  if (update_btns) update_btns.click(update_tb);

}

$(init);
