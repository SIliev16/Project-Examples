// Register service worker
if ('serviceWorker' in navigator) {
    window.addEventListener('load', function () {
        navigator.serviceWorker.register('/service-worker.js').then(function (registration) {
            console.log('ServiceWorker registration successful with scope: ', registration.scope);
        }, function (err) {
            console.log('ServiceWorker registration failed: ', err);
        });
    });
}

// Install service worker
self.addEventListener('install', function (event) {
    console.log('ServiceWorker installed');
});

// Activate service worker
self.addEventListener('activate', function (event) {
    console.log('ServiceWorker activated');
});

// Fetch event listener
self.addEventListener('fetch', function (event) {
    console.log('ServiceWorker fetch event:', event.request.url);
});