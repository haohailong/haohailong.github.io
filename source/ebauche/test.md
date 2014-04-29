---
layout: page
title: "test"
date: 2014-04-23 16:06
comments: true
sharing: true
footer: true
---

{% gistapi 11391053 %}

~~~
def hello
  puts "hello world"
end
~~~
{:lang="ruby"}

{% coderay lang:cplusplus linenos:true This is a great example! http://fritz-hut.com My Blog %}
// Get all the fiducials from the Sim proxy
for (int f = 0; f < 6; f++) {
    double x, y, a;
    sprintf(fidBuff, "Fid%d", f+1);
    simProxy.GetPose2d(fidBuff, x, y, a);
    FiducialObjects[f][0] = f;
    FiducialObjects[f][1] = x;
    FiducialObjects[f][2] = y;
}
{% endcoderay %}
