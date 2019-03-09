import { Controller } from "stimulus"

export default class extends Controller {
  get vapidPublicKey() {
    return this.urlBase64ToUint8Array(this.element.dataset.vapidPublicKey);
  }

  register() {
		// Let's check if the browser supports notifications
		if (!("Notification" in window)) {
			console.error("This browser does not support desktop notification");
		}
		// Let's check whether notification permissions have already been granted
		else if (Notification.permission === "granted") {
			console.log("Permission to receive notifications has been granted");
		}
		// Otherwise, we need to ask the user for permission
		else if (Notification.permission !== 'denied') {
			Notification.requestPermission(function (permission) {
				// If the user accepts, let's create a notification
				if (permission === "granted") {
					console.log("Permission to receive notifications has been granted");
				}
			});
		}

    navigator.serviceWorker.ready.then((serviceWorkerRegistration) => {
      serviceWorkerRegistration.pushManager
        .subscribe({
          userVisibleOnly: true,
          applicationServerKey: this.vapidPublicKey
        }).then(this.sendSubscriptionToServer);
    });
  }

  sendSubscriptionToServer(subscription) {
    console.log(subscription.toJSON());
    $.post("/my/push_notification_registrations", { subscription: subscription.toJSON(), message: "You clicked a button!" });
  }

  urlBase64ToUint8Array(base64String) {
    const padding = '='.repeat((4 - base64String.length % 4) % 4);
    const base64 = (base64String + padding)
      .replace(/\-/g, '+')
      .replace(/_/g, '/');

    const rawData = window.atob(base64);
    const outputArray = new Uint8Array(rawData.length);

    for (let i = 0; i < rawData.length; ++i) {
      outputArray[i] = rawData.charCodeAt(i);
    }
    return outputArray;
  }
}
