// Script Name: manga-bot

const puppeteer = require('puppeteer');

module.exports.sendManga = sendManga;
async function sendManga(chapter) {
    // Launch the browser and open a new blank page
    const browser = await puppeteer.launch({ headless: "new", args: ['--start-maximized'] });
    const page = await browser.newPage();

    page.on('dialog', async dialog => {
        console.log(dialog.message())
        await dialog.accept()
    });

    var chptLink = "https://comick.io/comic/00-one-piece/WrjZQ-chapter-" + chapter + "-en";
    var saveName = "one-piece-" + chapter + ".pdf";

    // Navigate the page to a URL
    await page.goto(chptLink, { waitUntil: 'networkidle0', timeout: 120000 });
    console.log("Navigation to Chapter " + chapter + " : SUCCESS");

    // Set screen size
    await page.setViewport({width: 1080, height: 1024});

    // Accept Age Verification
    // await page.click('#headlessui-description-\:r9\: > div > div.w-full.flex.justify-center > div > button');
    
    // Save the page as a PDF
    await page.pdf({ path: "one-piece/"+saveName, format: 'A4', timeout: 0 });
    console.log("Chapter " + chapter + " saved as PDF : SUCCESS");

    await browser.close();

};