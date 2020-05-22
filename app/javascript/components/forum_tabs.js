const initForumTabs = () => {
  const forumTabs = document.querySelectorAll(".forum_tab")
  if (forumTabs.length !== 0) {
    const forumTabContent = document.querySelectorAll(".forum-tab-content")
    forumTabs.forEach((tab, i) => {
      tab.addEventListener('click', () => {
        forumTabContent.forEach(content => content.classList.remove("active-tab"))
        forumTabContent[i].classList.add("active-tab");
      })
    })
    if (window.location.pathname.includes("forum")) {
      forumTabContent[0].classList.add("active-tab");
    } else {
      forumTabContent[1].classList.add("active-tab");
    }
  }
}

export { initForumTabs }
