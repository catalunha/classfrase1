# classfrase

A new Flutter project.

# Web

flutter build web --web-renderer html
firebase deploy --only hosting:classfrase


# use npm
// Import the functions you need from the SDKs you need
import { initializeApp } from "firebase/app";
import { getAnalytics } from "firebase/analytics";
// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries

// Your web app's Firebase configuration
// For Firebase JS SDK v7.20.0 and later, measurementId is optional
const firebaseConfig = {
  apiKey: "AIzaSyBvqGlhQwJzdzEqPDUNv89z_NmTGMKEvPA",
  authDomain: "classfrase.firebaseapp.com",
  projectId: "classfrase",
  storageBucket: "classfrase.appspot.com",
  messagingSenderId: "402048970695",
  appId: "1:402048970695:web:25489253669cfe0731f3e2",
  measurementId: "G-XZJZNYL9HC"
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);
const analytics = getAnalytics(app);

# use tag
<script type="module">
  // Import the functions you need from the SDKs you need
  import { initializeApp } from "https://www.gstatic.com/firebasejs/9.1.1/firebase-app.js";
  import { getAnalytics } from "https://www.gstatic.com/firebasejs/9.1.1/firebase-analytics.js";
  // TODO: Add SDKs for Firebase products that you want to use
  // https://firebase.google.com/docs/web/setup#available-libraries

  // Your web app's Firebase configuration
  // For Firebase JS SDK v7.20.0 and later, measurementId is optional
  const firebaseConfig = {
    apiKey: "AIzaSyBvqGlhQwJzdzEqPDUNv89z_NmTGMKEvPA",
    authDomain: "classfrase.firebaseapp.com",
    projectId: "classfrase",
    storageBucket: "classfrase.appspot.com",
    messagingSenderId: "402048970695",
    appId: "1:402048970695:web:25489253669cfe0731f3e2",
    measurementId: "G-XZJZNYL9HC"
  };

  // Initialize Firebase
  const app = initializeApp(firebaseConfig);
  const analytics = getAnalytics(app);
</script>