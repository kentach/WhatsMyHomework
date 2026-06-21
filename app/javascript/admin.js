import "bootstrap";
import "admin-lte";

document.addEventListener("turbo:load", initAdmin);
document.addEventListener("DOMContentLoaded", initAdmin);

function initAdmin() {
  // サイドバー自動ハイライト
  const currentPath = window.location.pathname;
  document.querySelectorAll(".nav-sidebar .nav-link").forEach((link) => {
    if (link.getAttribute("href") === currentPath) {
      link.classList.add("active");
    }
  });

  // フラッシュメッセージ自動消去
  document.querySelectorAll(".alert.auto-dismiss").forEach((alert) => {
    setTimeout(() => {
      alert.style.transition = "opacity 0.5s";
      alert.style.opacity = "0";
      setTimeout(() => alert.remove(), 500);
    }, 3000);
  });

  // タスク追加
  const addTaskBtn = document.getElementById("add-task");
  const tasksContainer = document.getElementById("tasks");

  if (addTaskBtn && tasksContainer) {
    addTaskBtn.addEventListener("click", () => {
      const index = tasksContainer.querySelectorAll(".task-fields").length;
      const html = `
        <div class="task-fields border rounded p-3 mb-2">
          <div class="mb-2">
            <label class="form-label">タスク名</label>
            <input class="form-control" type="text" name="homework[tasks_attributes][${index}][name]">
          </div>
          <div class="mb-2">
            <label class="form-label">PDF</label>
            <input class="form-control" type="file" name="homework[tasks_attributes][${index}][pdf]" accept="application/pdf">
          </div>
          <button type="button" class="btn btn-outline-danger btn-sm remove-task">削除</button>
        </div>`;
      tasksContainer.insertAdjacentHTML("beforeend", html);
    });

    tasksContainer.addEventListener("click", (e) => {
      if (e.target.classList.contains("remove-task")) {
        const taskField = e.target.closest(".task-fields");
        const destroyFlag = taskField.querySelector(".destroy-flag");
        if (destroyFlag) {
          destroyFlag.value = "1";
          taskField.style.display = "none";
        } else {
          taskField.remove();
        }
      }
    });
  }
}