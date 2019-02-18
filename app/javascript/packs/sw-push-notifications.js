console.log('[Service Worker: Push Notifications] Hello world!');

self.addEventListener("push", (event) => {
  let title = (event.data && event.data.text()) || "Yay a message";
  let body = "We have received a push message";
  let tag = "push-simple-demo-notification-tag";
  let icon = '/assets/my-logo-120x120.png';

  console.log(event)
  event.waitUntil(
    // self.registration.showNotification(title, { body, icon, tag })
    self.registration.showNotification(title, { body: 'Body of message' })
  )
});
