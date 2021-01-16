import http from 'k6/http';
import { check, sleep } from 'k6';
export const options = {
  vus: 2,
  duration: '2s',
};
export default function () {
  const res = http.get('https://qq.com');
  check(res, {
    'is status 200': (r) => r.status === 200,
  });
  // console.log('Body was ' + String(res.body));
  // console.log('Response time was ' + String(res.timings.duration) + ' ms');
  sleep(1);
}

