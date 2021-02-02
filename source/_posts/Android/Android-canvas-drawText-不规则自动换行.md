---
title: Android-canvas-drawText-不规则自动换行
date: 2016-07-01 16:01:33
categories: Android
tags: android
---

<meta name="referrer" content="no-referrer" />


最近有个需求，水印图片，右上角有个logo，然后上面有些文字。涉及到不规则自动换行
![image.png](https://upload-images.jianshu.io/upload_images/2803682-bc74cf6392dc84bc.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
开始考虑StaticLayout 直接处理，发现每行都是一样宽度。。然后想到了一些其他的方法，挺简单的还不错

```
/**
 * Created by Lrxc on 2018/6/13.17:17
 * Email: Lrxc1117@163.com
 */
public class MyView extends View {
    private final int screenWidth;//屏幕宽度
    private final TextPaint textPaint;//画笔
    private final int textSize = 50;//画笔大小
    private final Bitmap logo;//logo图片
    private final int logoPadingTop = 200;//logo上边距

    private final String str = "我仰望星空，浩瀚的银河系，哪一颗才是属于我的那个你？无论你在哪里，我都等着你，盼着你，直到遇见你。如果你看见了我，请你一定联系我，请不要让我等的太久，我会遗憾陪伴你的日子太过短暂。" +
            "我仰望星空，浩瀚的银河系，哪一颗才是属于我的那个你？无论你在哪里，我都等着你，盼着你，直到遇见你。如果你看见了我，请你一定联系我，请不要让我等的太久，我会遗憾陪伴你的日子太过短暂";

    public MyView(Context context, @Nullable AttributeSet attrs) {
        super(context, attrs);

        textPaint = new TextPaint();
        textPaint.setTextSize(textSize);
        textPaint.setColor(Color.RED);

        DisplayMetrics dm = getResources().getDisplayMetrics();
        screenWidth = dm.widthPixels;

        logo = BitmapFactory.decodeResource(getResources(), R.mipmap.ic_launcher);
    }

    @Override
    protected void onDraw(Canvas canvas) {
        super.onDraw(canvas);
        //绘制logo
        canvas.drawBitmap(logo, screenWidth - logo.getWidth() - 5, logoPadingTop, null);
        //绘制不规则文字
        lineFeed(canvas, str, textSize);
    }

    /**
     * @param canvas 画布
     * @param str    绘制内容
     * @param heigth 每一行的高度
     */
    private void lineFeed(Canvas canvas, String str, int heigth) {
        int lineWidth = screenWidth;
        //右边有logo 空出位置
        if (heigth >= logoPadingTop && heigth <= logoPadingTop + logo.getHeight() + textSize) {
            lineWidth = screenWidth - logo.getWidth();
        }
        //计算当前宽度(width)能显示多少个汉字
        int subIndex = textPaint.breakText(str, 0, str.length(), true, lineWidth, null);
        //截取可以显示的汉字
        String mytext = str.substring(0, subIndex);
        canvas.drawText(mytext, 0, heigth, textPaint);

        //计算剩下的汉字
        String ss = str.substring(subIndex, str.length());
        if (ss.length() > 0) {
            lineFeed(canvas, ss, heigth + textSize + 10);
        }
    }
}
```
