const initChannelTabs = () => {
  const channelTabs = document.querySelectorAll(".channel-tab")
  if (channelTabs.length !== 0) {
    const channelTabContent = document.querySelectorAll(".channel-tab-content")
    channelTabs.forEach((tab, i) => {
      tab.addEventListener('click', () => {
        channelTabContent.forEach(content => content.classList.remove("active-tab"))
        channelTabContent[i].classList.add("active-tab");
      })
    })
    if (window.location.pathname.includes("forum")) {
      channelTabContent[0].classList.add("active-tab");
    } else {
      channelTabContent[1].classList.add("active-tab");
    }
  }
}

export { initChannelTabs }
