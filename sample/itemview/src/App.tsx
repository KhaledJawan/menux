import svgPaths from "./imports/svg-19jqw17zjq";
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

export default function App() {
  return (
    <div className="bg-white min-h-screen w-full max-w-[430px] mx-auto">
      <div className="bg-white rounded-tl-[40px] rounded-tr-[40px] p-[28px] pb-[40px]">
        {/* Product Image */}
        <div className="rounded-[16px] w-full aspect-square mb-[18px] overflow-hidden">
          <img 
            alt="Cappuccino" 
            className="w-full h-full object-cover" 
            src={imgRectangle5} 
          />
        </div>

        {/* Title and Rating */}
        <div className="flex items-center justify-between mb-[10px]">
          <p className="font-['Ubuntu:Bold',sans-serif] leading-[normal] not-italic text-[26px] text-black text-nowrap whitespace-pre">Cappuccino</p>
          <div className="content-stretch flex h-[37px] items-center justify-end shrink-0 w-[84px]">
            <DefaultBoldStar />
            <DefaultBoldStar />
            <DefaultBoldStar1 />
            <DefaultBoldStar />
            <DefaultOutlineStar />
          </div>
        </div>

        {/* Description */}
        <p className="font-['Ubuntu:Regular',sans-serif] leading-[20px] not-italic text-[#949494] text-[16px] mb-[35px]">Lorem ipsum dolor sit amet consectetur. Cursus consectetur enim consectetur lectus. Dis sociis pharetra dignissim lorem pretium sed faucibus.</p>

        {/* Size Selection */}
        <div className="flex gap-[11px] mb-[12px] justify-center">
          <div className="bg-white box-border content-stretch flex flex-col gap-[10px] h-[60px] items-start p-[18px] relative rounded-[16px] shrink-0">
            <div aria-hidden="true" className="absolute border border-black border-solid inset-0 pointer-events-none rounded-[16px]" />
            <div className="content-stretch flex gap-[5px] items-center relative shrink-0">
              <Group />
              <p className="font-['Ubuntu:Medium',sans-serif] leading-[normal] not-italic relative shrink-0 text-[16px] text-black text-nowrap whitespace-pre">S</p>
            </div>
          </div>
          
          <div className="bg-neutral-100 box-border content-stretch flex flex-col gap-[10px] h-[60px] items-start p-[18px] relative rounded-[16px] shrink-0">
            <div className="content-stretch flex gap-[5px] items-center relative shrink-0">
              <Group3 />
              <p className="font-['Ubuntu:Medium',sans-serif] leading-[normal] not-italic relative shrink-0 text-[16px] text-black text-nowrap whitespace-pre">M</p>
            </div>
          </div>
          
          <div className="bg-neutral-100 box-border content-stretch flex flex-col gap-[10px] h-[60px] items-start p-[18px] relative rounded-[16px] shrink-0">
            <div className="content-stretch flex gap-[5px] items-center relative shrink-0">
              <Group3 />
              <p className="font-['Ubuntu:Medium',sans-serif] leading-[normal] not-italic relative shrink-0 text-[16px] text-black text-nowrap whitespace-pre">L</p>
            </div>
          </div>
        </div>

        {/* Comment Input */}
        <div className="bg-white border border-[#949494] border-dashed h-[60px] rounded-[16px] w-full mb-[43px] flex items-center px-[18px]">
          <p className="font-['Ubuntu:Medium',sans-serif] leading-[normal] not-italic text-[#d9d9d9] text-[16px] text-nowrap whitespace-pre">Comment</p>
        </div>

        {/* Quantity and Add to Cart */}
        <div className="flex gap-[12px] items-center">
          <div className="bg-neutral-100 box-border content-stretch flex flex-col gap-[10px] h-[60px] items-start min-w-[130px] px-[15px] py-[18px] relative rounded-[16px] shrink-0 w-[140px]">
            <div className="content-stretch flex gap-[20px] items-center justify-center relative shrink-0 w-full">
              <DefaultOutlineMinus />
              <p className="font-['Ubuntu:Medium',sans-serif] leading-[normal] not-italic relative shrink-0 text-[20px] text-black text-center text-nowrap whitespace-pre">1</p>
              <DefaultOutlineAdd />
            </div>
          </div>
          
          <div className="bg-black box-border content-stretch flex flex-col gap-[10px] h-[60px] items-start min-w-[130px] px-[15px] py-[18px] relative rounded-[16px] shrink-0 w-[212px]">
            <div className="font-['Ubuntu:Medium',sans-serif] h-[21px] leading-[normal] not-italic relative shrink-0 text-[18px] text-nowrap text-white w-[185px] whitespace-pre">
              <p className="absolute left-[46.5px] text-center top-0 translate-x-[-50%]">Add to cart</p>
              <p className="absolute left-[185px] text-right top-0 translate-x-[-100%]">€4.50</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}
