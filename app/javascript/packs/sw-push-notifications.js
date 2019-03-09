console.log('[Service Worker: Push Notifications] Hello world!');

self.addEventListener('push', function(event) {
  if (event.data) {
    json = event.data.json()

    console.log(json)
    event.waitUntil(
      self.registration.showNotification(json.title, json)
    )
  }
});

self.addEventListener('notificationclick', function(event) {
  console.log('Notification click: tag ', event.notification.tag);
  event.notification.close();

  var action = event.action;
  var path = event.notification.data.path || '/';
  const urlToOpen = new URL(path, self.location.origin).href;

  if (action == 'open-path') {
    event.waitUntil(
      clients.matchAll({
        type: "window",
        includeUncontrolled: true
      }).then((clientList) => {
        for (var i = 0; i < clientList.length; i++) {
          var client = clientList[i];
          if (client.url == urlToOpen && 'focus' in client) {
            return client.focus();
          }
        }
        if (clients.openWindow) {
          return clients.openWindow(urlToOpen);
        }
      })
    )
  }
});

