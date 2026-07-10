import"https://cdn.tailwindcss.com";const S={P:1,U:2,L:3,S:4,PL:5,PU:6,LU:7,SU:8,PUL:9,LPS:10,SPU:11,ULS:12};let i=[];const h=a=>document.getElementById(a);function v(){const a=h("wave-quantum-container");if(!a||i.length===0)return;let d="";i.forEach((n,e)=>{const o=e*1,t=1-e*.08;if(t<=0)return;const c=18;[{id:"internal",r:o*1*c,opacity:t*.7,value:n.sets},{id:"intermediate",r:o*1.4*c,opacity:t*.55,value:n.vector},{id:"external",r:o*1.8*c,opacity:t*.4,value:n.reps}].forEach(r=>{if(r.r<=0)return;const l=2*Math.PI*r.r,s=(r.value-1)*30,L=`${r.value/12*l} ${l}`;d+=`
                        <circle 
                            id="wave-${r.id}-t${e}" 
                            cx="200" 
                            cy="200" 
                            r="${r.r}" 
                            transform="rotate(${s} 200 200)"
                            class="stroke-current"
                            stroke-width="${e===0?1.5:1}"
                            stroke-opacity="${r.opacity}"
                            stroke-dasharray="${L}"
                            stroke-linecap="round"
                            fill="none"
                        />`})}),a.innerHTML=d}function f(){const a=new Date,d=a.getMinutes(),n=a.getSeconds();let e=1,o=1,t="P";if(n%2!==0){const s=a.getMilliseconds()/1e3;e=Math.floor(s*12)+1,o=13-e,s<.25?t="P":s<.5?t="U":s<.75?t="L":t="S"}else if(e=Math.floor(d%12+1),n<30){const s=Math.floor(n%30/7.5);t=["PL","PU","LU","SU"][s]||"PL",o=Math.floor(n%10+2)}else{const s=Math.floor((n-30)%30/7.5);t=["PUL","LPS","SPU","ULS"][s]||"ULS",o=Math.floor((n-30)%10+3)}e=Math.max(1,Math.min(12,e)),o=Math.max(1,Math.min(12,o));const c=`${e}${t}${o}`,u=S[t]||1,r=i[0];(!r||r.rawCoord!==c)&&(i.unshift({sets:e,vector:u,reps:o,rawCoord:c}),i.length>12&&i.pop()),v();const l=h("z-dial");l&&(l.textContent=c)}document.readyState==="loading"?document.addEventListener("DOMContentLoaded",()=>{f(),setInterval(f,1e3)}):(f(),setInterval(f,1e3));
