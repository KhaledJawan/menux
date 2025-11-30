import svgPaths from "./svg-19jqw17zjq";
import imgRectangle5 from "figma:asset/45514c6705e6dee561920684d4bc3e60f94ba2cd.png";

function Star() {
  return (
    <div className="absolute inset-[8.66%_8.32%_8.68%_8.34%]" data-name="star">
      <svg className="block size-full" fill="none" preserveAspectRatio="none" viewBox="0 0 15 14">
        <g id="star">
          <path d={svgPaths.pd6f9a80} fill="var(--fill-0, #FFCC00)" id="Vector" />
        </g>
      </svg>
    </div>
  );
}

function VuesaxBoldStar() {
  return (
    <div className="absolute contents inset-[8.66%_8.32%_8.68%_8.34%]" data-name="vuesax/bold/star">
      <Star />
    </div>
  );
}

function DefaultBoldStar() {
  return (
    <div className="h-[16px] relative shrink-0 w-[17px]" data-name="default/bold/star">
      <VuesaxBoldStar />
    </div>
  );
}

function Star1() {
  return (
    <div className="absolute inset-[8.66%_8.32%_8.68%_8.34%]" data-name="star">
      <svg className="block size-full" fill="none" preserveAspectRatio="none" viewBox="0 0 14 14">
        <g id="star">
          <path d={svgPaths.p2b594f00} fill="var(--fill-0, #FFCC00)" id="Vector" />
        </g>
      </svg>
    </div>
  );
}

function VuesaxBoldStar1() {
  return (
    <div className="absolute contents inset-[8.66%_8.32%_8.68%_8.34%]" data-name="vuesax/bold/star">
      <Star1 />
    </div>
  );
}

function DefaultBoldStar1() {
  return (
    <div className="relative shrink-0 size-[16px]" data-name="default/bold/star">
      <VuesaxBoldStar1 />
    </div>
  );
}

function VuesaxOutlineStar() {
  return (
    <div className="absolute contents inset-0" data-name="vuesax/outline/star">
      <svg className="block size-full" fill="none" preserveAspectRatio="none" viewBox="0 0 17 16">
        <g id="star">
          <path d={svgPaths.p3481ae00} fill="var(--fill-0, #FFCC00)" id="Vector" />
          <g id="Vector_2" opacity="0"></g>
        </g>
      </svg>
    </div>
  );
}

function DefaultOutlineStar() {
  return (
    <div className="h-[16px] relative shrink-0 w-[17px]" data-name="default/outline/star">
      <VuesaxOutlineStar />
    </div>
  );
}

function Frame2() {
  return (
    <div className="content-stretch flex h-[37px] items-center justify-end relative shrink-0 w-[84px]">
      <DefaultBoldStar />
      <DefaultBoldStar />
      <DefaultBoldStar1 />
      <DefaultBoldStar />
      <DefaultOutlineStar />
    </div>
  );
}

function Frame9() {
  return (
    <div className="absolute content-stretch flex gap-[24px] items-center left-[27px] top-[393px]">
      <p className="font-['Ubuntu:Bold',sans-serif] leading-[normal] not-italic relative shrink-0 text-[26px] text-black text-nowrap whitespace-pre">Cappuccino</p>
      <Frame2 />
    </div>
  );
}

function VuesaxBoldMouse() {
  return (
    <div className="absolute contents inset-0" data-name="vuesax/bold/mouse">
      <svg className="block size-full" fill="none" preserveAspectRatio="none" viewBox="0 0 24 24">
        <g id="mouse">
          <path d="M24 0H0V24H24V0Z" fill="var(--fill-0, black)" id="Vector" opacity="0" />
          <path d={svgPaths.pc812880} fill="var(--fill-0, black)" id="Vector_2" />
        </g>
      </svg>
    </div>
  );
}

function DefaultBoldMouse() {
  return (
    <div className="[grid-area:1_/_1] ml-0 mt-0 relative size-[24px]" data-name="default/bold/mouse">
      <VuesaxBoldMouse />
    </div>
  );
}

function Group() {
  return (
    <div className="grid-cols-[max-content] grid-rows-[max-content] inline-grid leading-[0] place-items-start relative shrink-0">
      <DefaultBoldMouse />
    </div>
  );
}

function Frame() {
  return (
    <div className="content-stretch flex gap-[5px] items-center relative shrink-0">
      <Group />
      <p className="font-['Ubuntu:Medium',sans-serif] leading-[normal] not-italic relative shrink-0 text-[16px] text-black text-nowrap whitespace-pre">S</p>
    </div>
  );
}

function Frame1() {
  return (
    <div className="bg-white box-border content-stretch flex flex-col gap-[10px] h-[60px] items-start p-[18px] relative rounded-[16px] shrink-0">
      <div aria-hidden="true" className="absolute border border-black border-solid inset-0 pointer-events-none rounded-[16px]" />
      <Frame />
    </div>
  );
}

function VuesaxOutlineMouse() {
  return (
    <div className="absolute contents inset-0" data-name="vuesax/outline/mouse">
      <svg className="block size-full" fill="none" preserveAspectRatio="none" viewBox="0 0 24 24">
        <g id="mouse">
          <path d={svgPaths.p32be3b80} fill="var(--fill-0, black)" id="Vector" />
          <path d={svgPaths.p261e480} fill="var(--fill-0, black)" id="Vector_2" />
          <path d="M24 0H0V24H24V0Z" fill="var(--fill-0, black)" id="Vector_3" opacity="0" />
        </g>
      </svg>
    </div>
  );
}

function DefaultOutlineMouse() {
  return (
    <div className="[grid-area:1_/_1] ml-0 mt-0 relative size-[24px]" data-name="default/outline/mouse">
      <VuesaxOutlineMouse />
    </div>
  );
}

function Group3() {
  return (
    <div className="grid-cols-[max-content] grid-rows-[max-content] inline-grid leading-[0] place-items-start relative shrink-0">
      <DefaultOutlineMouse />
    </div>
  );
}

function Frame4() {
  return (
    <div className="content-stretch flex gap-[5px] items-center relative shrink-0">
      <Group3 />
      <p className="font-['Ubuntu:Medium',sans-serif] leading-[normal] not-italic relative shrink-0 text-[16px] text-black text-nowrap whitespace-pre">M</p>
    </div>
  );
}

function Frame10() {
  return (
    <div className="bg-neutral-100 box-border content-stretch flex flex-col gap-[10px] h-[60px] items-start p-[18px] relative rounded-[16px] shrink-0">
      <Frame4 />
    </div>
  );
}

function VuesaxOutlineMouse1() {
  return (
    <div className="absolute contents inset-0" data-name="vuesax/outline/mouse">
      <svg className="block size-full" fill="none" preserveAspectRatio="none" viewBox="0 0 24 24">
        <g id="mouse">
          <path d={svgPaths.p32be3b80} fill="var(--fill-0, black)" id="Vector" />
          <path d={svgPaths.p261e480} fill="var(--fill-0, black)" id="Vector_2" />
          <path d="M24 0H0V24H24V0Z" fill="var(--fill-0, black)" id="Vector_3" opacity="0" />
        </g>
      </svg>
    </div>
  );
}

function DefaultOutlineMouse1() {
  return (
    <div className="[grid-area:1_/_1] ml-0 mt-0 relative size-[24px]" data-name="default/outline/mouse">
      <VuesaxOutlineMouse1 />
    </div>
  );
}

function Group4() {
  return (
    <div className="grid-cols-[max-content] grid-rows-[max-content] inline-grid leading-[0] place-items-start relative shrink-0">
      <DefaultOutlineMouse1 />
    </div>
  );
}

function Frame11() {
  return (
    <div className="content-stretch flex gap-[5px] items-center relative shrink-0">
      <Group4 />
      <p className="font-['Ubuntu:Medium',sans-serif] leading-[normal] not-italic relative shrink-0 text-[16px] text-black text-nowrap whitespace-pre">L</p>
    </div>
  );
}

function Frame3() {
  return (
    <div className="bg-neutral-100 box-border content-stretch flex flex-col gap-[10px] h-[60px] items-start p-[18px] relative rounded-[16px] shrink-0">
      <Frame11 />
    </div>
  );
}

function Frame7() {
  return (
    <div className="content-stretch flex gap-[11px] items-center relative shrink-0">
      <Frame1 />
      <Frame10 />
      <Frame3 />
    </div>
  );
}

function Frame12() {
  return (
    <div className="absolute content-stretch flex gap-[11px] items-center left-[76px] top-[518px] w-[250px]">
      <Frame7 />
    </div>
  );
}

function Group5() {
  return (
    <div className="absolute contents left-[23px] top-[589px]">
      <div className="absolute bg-white border border-[#949494] border-dashed h-[60px] left-[23px] rounded-[16px] top-[589px] w-[356px]" />
      <p className="absolute font-['Ubuntu:Medium',sans-serif] leading-[normal] left-[75.5px] not-italic text-[#d9d9d9] text-[16px] text-center text-nowrap top-[610px] translate-x-[-50%] whitespace-pre">Comment</p>
    </div>
  );
}

function VuesaxOutlineMinus() {
  return (
    <div className="absolute contents inset-0" data-name="vuesax/outline/minus">
      <svg className="block size-full" fill="none" preserveAspectRatio="none" viewBox="0 0 24 24">
        <g id="minus">
          <path d={svgPaths.p3d9bb080} fill="var(--fill-0, black)" id="Vector" />
          <g id="Vector_2" opacity="0"></g>
        </g>
      </svg>
    </div>
  );
}

function DefaultOutlineMinus() {
  return (
    <div className="relative shrink-0 size-[24px]" data-name="default/outline/minus">
      <VuesaxOutlineMinus />
    </div>
  );
}

function VuesaxOutlineAdd() {
  return (
    <div className="absolute contents inset-0" data-name="vuesax/outline/add">
      <svg className="block size-full" fill="none" preserveAspectRatio="none" viewBox="0 0 24 24">
        <g id="add">
          <path d={svgPaths.p3d9bb080} fill="var(--fill-0, black)" id="Vector" />
          <path d={svgPaths.p4cbce00} fill="var(--fill-0, black)" id="Vector_2" />
          <g id="Vector_3" opacity="0"></g>
        </g>
      </svg>
    </div>
  );
}

function DefaultOutlineAdd() {
  return (
    <div className="relative shrink-0 size-[24px]" data-name="default/outline/add">
      <VuesaxOutlineAdd />
    </div>
  );
}

function Frame6() {
  return (
    <div className="content-stretch flex gap-[20px] items-center justify-center relative shrink-0 w-full">
      <DefaultOutlineMinus />
      <p className="font-['Ubuntu:Medium',sans-serif] leading-[normal] not-italic relative shrink-0 text-[20px] text-black text-center text-nowrap whitespace-pre">1</p>
      <DefaultOutlineAdd />
    </div>
  );
}

function Frame5() {
  return (
    <div className="bg-neutral-100 box-border content-stretch flex flex-col gap-[10px] h-[60px] items-start min-w-[130px] px-[15px] py-[18px] relative rounded-[16px] shrink-0 w-[140px]">
      <Frame6 />
    </div>
  );
}

function Frame13() {
  return (
    <div className="font-['Ubuntu:Medium',sans-serif] h-[21px] leading-[normal] not-italic relative shrink-0 text-[18px] text-nowrap text-white w-[185px] whitespace-pre">
      <p className="absolute left-[46.5px] text-center top-0 translate-x-[-50%]">Add to cart</p>
      <p className="absolute left-[185px] text-right top-0 translate-x-[-100%]">€4.50</p>
    </div>
  );
}

function Frame14() {
  return (
    <div className="bg-black box-border content-stretch flex flex-col gap-[10px] h-[60px] items-start min-w-[130px] px-[15px] py-[18px] relative rounded-[16px] shrink-0 w-[212px]">
      <Frame13 />
    </div>
  );
}

function Frame8() {
  return (
    <div className="absolute content-stretch flex gap-[12px] items-center left-[23px] top-[692px]">
      <Frame5 />
      <Frame14 />
    </div>
  );
}

function Group1() {
  return (
    <div className="absolute contents left-[23px] top-[28px]">
      <div className="absolute left-[28px] rounded-[16px] size-[347px] top-[28px]">
        <div className="absolute inset-0 overflow-hidden pointer-events-none rounded-[16px]">
          <img alt="" className="absolute h-full left-[-40.23%] max-w-none top-0 w-[149.95%]" src={imgRectangle5} />
        </div>
      </div>
      <Frame9 />
      <p className="absolute font-['Ubuntu:Regular',sans-serif] h-[77px] leading-[20px] left-[28px] not-italic text-[#949494] text-[16px] top-[433px] w-[347px]">Lorem ipsum dolor sit amet consectetur. Cursus consectetur enim consectetur lectus. Dis sociis pharetra dignissim lorem pretium sed faucibus.</p>
      <Frame12 />
      <Group5 />
      <Frame8 />
    </div>
  );
}

export default function Group2() {
  return (
    <div className="relative size-full">
      <div className="absolute bg-white h-[796px] left-0 rounded-tl-[40px] rounded-tr-[40px] top-0 w-[402px]" />
      <Group1 />
    </div>
  );
}